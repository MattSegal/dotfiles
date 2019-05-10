. ~/dotfiles/bash-secrets.sh

alias dc="docker-compose"
alias python=python3

function stopdocker {
    docker update --restart=no `docker ps -q`
    docker kill `docker ps -q`
}

function github {
  branch="$(git rev-parse --abbrev-ref HEAD)"
  repo="$(git remote -v | cut -d ':' -f 2 | cut -d '.' -f 1 | head -1)"

  case "$1" in
    "diff")
      url="https://github.com/${repo}/compare/${branch}"
      ;;
    *)
      url="https://github.com/${repo}/tree/${branch}"
      ;;
  esac

  chromium-browser "$url"
}

function upstream {
  branch="$(git rev-parse --abbrev-ref HEAD)"
  git branch --set-upstream-to="origin/${branch}" "$branch"
}

function manage {
  case "$1" in
    "")
      echo "Django manage wrapper"
      echo

      echo "  up            bring up web container"
      echo "  debug         bring up web container with service ports"
      echo "  reset         reset database (sdadmin password is 'z')"
      echo "  postgres      open Postgres CLI"
      echo "  lint          run linter"
      echo "  isort         apply isort"
      echo "  test          run tests"
      echo "  shell         run shell_plus"
      echo "  fetch         fetch prod data"
      echo "  restore       restore local db from prod data"
      echo "  ssh           ssh into prod, staging or backup"
      echo "  rollback      rollback deployment to prod or staging"
      echo "  *             pass args to manage.py"
      echo
      ;;
    "up")
      docker-compose up web
      ;;
    "debug")
      docker-compose run --service-ports web
      ;;
    "reset")
      echo -ne 'z\nz\n' | docker-compose run web ./scripts/reset-db.sh
      ;;
    "ssh")
      case "$2" in
        "prod")
          SERVER="$PROD_1_EC2"
          ;;
        "staging")
          SERVER="$STAGING_EC2"
          ;;
        "backup")
          SERVER="$BACKUP_EC2"
          ;;
        *)
          echo "No environment specified for SSH."
          return
          ;;
      esac
      echo -e "\n\t===============\n\tSSH into $2\n\t===============\n"
      ssh "ec2-user@$SERVER" -i $SD_SSH_KEY
      ;;
    "rollback")
      case "$2" in
        "prod")
          echo "Rolling back prod to '${3}'"
          $SCRIPTS_DIR/deploy/rollback-prod.sh "$3"
          ;;
        "staging")
          echo "Rolling back staging to '${3}'"
          $SCRIPTS_DIR/deploy/rollback-staging.sh "$3"
          ;;
        *)
          echo "No environment specified for rollback."
          return
          ;;
      esac
      ;;
    "fetch")
      $SCRIPTS_DIR/backups/fetch-prod.sh
      ;;
    "restore")
      $SCRIPTS_DIR/backups/restore-local.sh
      ;;
    "postgres")
      psql --host=0.0.0.0 --port=25432 --username=postgres
      ;;
    "test")
      case "$2" in
        "")
          docker-compose run web make test
          ;;
        *)
          docker-compose run web pytest -s $2
        ;;
      esac
      ;;
    "lint")
      docker-compose run web make lint
      ;;
    "isort")
      docker-compose run web isort --skip migrations --skip node_modules
      ;;
    "shell")
      docker-compose run web ./manage.py shell_plus
      ;;
    *)
      docker-compose run web ./manage.py "$@"
      ;;
  esac
}
