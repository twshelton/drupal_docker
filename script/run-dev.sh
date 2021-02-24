docker run --rm -ti -p 8081:80 \
  --name=skillpointe \
  -v /Users/twshelton/Workspace/SkillPointe/SITE:/var/www/skillpointe.com/html \
  -v /Users/twshelton/Workspace/SkillPointe/FILES:/var/www/skillpointe.com/html/sites/default/files \
  -v /Users/twshelton/Workspace/SkillPointe/DATA:/root/data \
  -v /Users/twshelton/Workspace/SkillPointe/docker/scripts:/root/scripts \
  skillpointe:latest
