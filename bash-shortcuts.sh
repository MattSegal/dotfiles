alias dc="docker-compose"
alias chrome="/opt/google/chrome/google-chrome"

function github {
  branch="$(git rev-parse --abbrev-ref HEAD)"
  
  case "$1" in
    "diff") 
      url="https://github.com/StocksDigital/catalysthunter_sdcms/compare/${branch}"
      ;;
    *)
      url="https://github.com/StocksDigital/catalysthunter_sdcms/tree/${branch}"
      ;;
  esac

  chrome "$url"
}

function upstream {
  branch="$(git rev-parse --abbrev-ref HEAD)"
  git branch --set-upstream-to="origin/${branch}" "$branch"
}