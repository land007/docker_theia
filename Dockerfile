FROM theiaide/theia:latest

MAINTAINER Yiqiu Jia <yiqiujia@hotmail.com>

#RUN npm install socket.io ws express http-proxy bagpipe chokidar request nodemailer await-signal log4js moment
RUN mkdir /home/theia/agent
RUN cd /home/theia/agent && npm init -y && npm install http-proxy
ADD proxy.js /home/theia/agent

EXPOSE 5050

#ENTRYPOINT [ "node", "/home/theia/agent/proxy.js" ]
ENTRYPOINT []
#CMD node /home/theia/src-gen/backend/main.js /home/project --hostname=0.0.0.0
#CMD node /home/theia/agent/proxy.js
CMD node /home/theia/agent/proxy.js > /tmp/node.out & node /home/theia/src-gen/backend/main.js /home/project --hostname=0.0.0.0

#docker rm -f theia; docker run -it --privileged -p 15050:5050 -p 13005:3000 --expose 9229 -p 19229:9229 -v "$(pwd):/project:cached" --name theia land007/theia:latest --inspect=0.0.0.0:19229
