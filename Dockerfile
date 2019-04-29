FROM theiaide/theia:latest

MAINTAINER Yiqiu Jia <yiqiujia@hotmail.com>

#RUN npm install socket.io ws express http-proxy bagpipe chokidar request nodemailer await-signal log4js moment
RUN mkdir /home/theia/agent
RUN cd /home/theia/agent && npm init -y && npm install http-proxy basic-auth
ADD proxy.js /home/theia/agent

USER root
RUN apk add --no-cache subversion screen python
RUN apk add --virtual build-dependencies build-base gcc
RUN npm install -g node-gyp supervisor && cd / && npm init -y && npm install socket.io ws express http-proxy bagpipe chokidar request nodemailer await-signal log4js moment
RUN chown -R theia:theia /node_modules && chown -R theia:theia /usr/local/lib/node_modules && chown -R theia:theia /home/theia/.npm && chown -R theia:theia /usr/local/bin/
USER theia

ENV username=land007
ENV password=fcea920f7412b5da7be0cf42b8c93759

EXPOSE 5050
#ENTRYPOINT [ "node", "/home/theia/agent/proxy.js" ]
ENTRYPOINT []
#CMD node /home/theia/src-gen/backend/main.js /home/project --hostname=0.0.0.0
#CMD node /home/theia/agent/proxy.js
CMD nohup node /home/theia/agent/proxy.js > /tmp/proxy.out & nohup node /home/theia/src-gen/backend/main.js /home/project --hostname=0.0.0.0 --startup-timeout=-1 --inspect=0.0.0.0:9229 > /tmp/theia.out & bash

#docker rm -f theia; docker run -it --privileged -p 15050:5050 --expose 9229 -p 19229:9229 -v "$(pwd):/home/project:cached" -e "username=land007" -e "password=fcea920f7412b5da7be0cf42b8c93759" --name theia land007/theia:latest
#docker rm -f theia; docker run -it --privileged --expose 1080 -p 1080:1080 --expose 3000 -p 3000:3000 -p 15050:5050 --expose 9229 -p 19229:9229 -v "$(pwd):/home/project:cached" -e "username=land007" -e "password=fcea920f7412b5da7be0cf42b8c93759" --name theia land007/theia:latest
