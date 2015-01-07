zenity --question --title='Vicdoz manager files' --text='Desea hacer un backup del sistema'
if [ $? -eq 0 ] ; then
dest="/media/vicdozExternal"
START=$(date +%s)
DATE=$(date '+%Y-%m-%d')
echo ">Backup from $(date '+%Y-%m-%d, %T, %A') starting..." |tee $dest/log/"backups_$DATE.log"
rsync -aAXv  --exclude={".*","Downloads"}  /home/vicdoz   $dest |tee $dest/log/"backups_$DATE.log"
rsync -aAXv  --exclude={"/media/Datos/no-sync","/media/Datos/System\ Volume\ Information"}  /media/Datos   $dest |tee $dest/log/"backups_$DATE.log"


FINISH=$(date +%s)
echo ">Backup finished... total time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$DATE) % 60 )) seconds"|tee $dest/log/"backups_$DATE.log"
echo "********************************" |tee $dest/log/"backups_$DATE.log"
 zenity --notification\
    --window-icon="info" \
    --text="Backup finished"

else
 zenity --notification\
    --window-icon="info" \
    --text="Backup canceled"
fi
exit
