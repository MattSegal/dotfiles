alias dc="docker-compose"
alias chrome="/opt/google/chrome/google-chrome"

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

  chrome "$url"
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
      echo "  reset         reset database"
      echo "  wordpress     pull down WordPress data"
      echo "  postgres      open Postgres CLI"
      echo "  lint          run linter"
      echo "  test          run tests"
      echo "  *             pass args to manage.py"
      echo
      ;;
    "reset") 
      docker-compose run web ./scripts/reset-db.sh
      manage changepassword sdadmin
      ;;
    "wordpress") 
      args="convert_wordpress --jsonurl http://catalysthunter.com/wp-json/wp/v2 --homepage 3"
      eval "docker-compose run web ./manage.py $args"
      ;; 
    "postgres")
      psql --host=0.0.0.0 --port=25432 --username=postgres
      ;;
    "test")
      docker-compose run web make test-python
      ;;
    "lint")
      docker-compose run web make lint-python
      ;;
    *)
      docker-compose run web ./manage.py "$@"
      ;;
  esac
}