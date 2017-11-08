alias dc="docker-compose"
alias chrome="/opt/google/chrome/google-chrome"
alias manage="docker-compose run web ./manage.py"

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
