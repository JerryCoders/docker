#! /bin/sh
cd ${VENDORS}
echo "bin/bash 执行"
if [ ! -e "init.lock" ]
then
        sed -i "s/DIY-PORT/"${PORT}"/g" ${HOME}/config.json
        sed -i "s/DIY-AC/"${ADMIN_EMAIL}"/g" ${HOME}/config.json
        sed -i "s/DIY-DB-SERVER/"${DB_SERVER}"/g" ${HOME}/config.json
        sed -i "s/DIY-DB-NAME/"${DB_NAME}"/g" ${HOME}/config.json
        sed -i "s/DIY-DB-PORT/"${DB_PORT}"/g" ${HOME}/config.json
        sed -i "s/MONGO-USER/"${DB_USER}"/g" ${HOME}/config.json
        sed -i "s/MONGO-PASS/"${DB_PASS}"/g" ${HOME}/config.json
        sed -i "s/MONGO-AUTH/"${DB_AUTH}"/g" ${HOME}/config.json
        cat ${HOME}/config.json | while read line
        do
            echo $line
        done
        mv ${HOME}/config.json ${VENDORS}
        cp ${VENDORS}/config.json ${HOME}
        cp ${VENDORS}/config.json ${HOME}/../
        cd ${VENDORS}
        git fetch origin v${VERSION}:v${VERSION}
        git checkout v${VERSION}
        yapi install -v ${VERSION}
        touch init.lock
fi
cd ${VENDORS}
# 先判断有没有CMD指定路径
if [ $1 ]
then
        node $i
else
        node server/app.js
fi