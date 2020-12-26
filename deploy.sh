rm -rf node_modules
npm cache clean --force
docker-compose docker-compose.yml up -d --build > deploy_result

if [ ! 0 = $? ]; then
        message=`cat deploy_result`
        curl --data "nextjs-test 프론트엔드 프로젝트 배포에 실패하였습니다.  $message" 'https://d-dive.slack.com/services/hooks/slackbot?token=7WOMm81rpCFOhNGNCt46ctS5&channel=%23mj-test'
else
        curl --data "nextjs-test 프론트엔드 프로젝트 배포에 성공하였습니다." 'https://d-dive.slack.com/services/hooks/slackbot?token=7WOMm81rpCFOhNGNCt46ctS5&channel=%23mj-test'
fi

# docker rmi $(docker images -f "dangling=true" -q)

# echo "remote volumn"
docker volume rm $(docker volume ls -qf dangling=true)

# echo "remote docker images"
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker images -a | sed '1 d' | awk '{print $3}' | xargs -L1 docker rmi -f