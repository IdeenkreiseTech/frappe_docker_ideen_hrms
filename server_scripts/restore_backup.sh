# Restore Backup
db_password=xxx
site_name=hrms.ideenkreisetech.com
db_backup=20250131_102245-edibles_localhost-database.sql.gz
public_file_backup=20250131_102245-edibles_localhost-files.tar
private_file_backup=20250131_102245-edibles_localhost-private-files.tar

cd ../
sudo docker cp server_scripts/backup/$db_backup $(sudo docker compose ps -q backend):/tmp
#sudo docker cp server_scripts/backup/$private_file_backup $(sudo docker compose ps -q backend):/tmp
#sudo docker cp server_scripts/backup/$public_file_backup $(sudo docker compose ps -q backend):/tmp
sudo docker compose exec backend bench --site $site_name restore /tmp/$db_backup  --mariadb-root-password $db_password
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend
