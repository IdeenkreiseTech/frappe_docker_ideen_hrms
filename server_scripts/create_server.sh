# Create Site and Install Application
db_password=xxx
admin_password=xxx
encryption_key=xxx
git_password=xxx
site_name=hrms.ideenkreisetech.com
TAG=1.0.0

cd ../
sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password
sudo docker pull ghcr.io/ideenkreisetech/ideen_hrms/ideen_hrms:$TAG
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml up -d
sudo docker compose exec backend bench new-site $site_name --mariadb-user-host-login-scope=% --db-root-password $db_password --admin-password $admin_password
sudo docker compose exec backend bench --site $site_name install-app erpnext
sudo docker compose exec backend bench --site $site_name install-app hrms
sudo docker compose exec backend bench --site $site_name install-app hrms_app
sudo docker compose exec backend bench --site $site_name set-config encryption_key $encryption_key
sudo docker compose exec backend bench --site $site_name enable-scheduler
