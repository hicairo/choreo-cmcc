From uffizzi/ttyd

ENV NEZHA_URI=33
ENV NEZHA_SECRET=44

RUN apt update -y && apt install curl sudo wget -y

RUN echo 'root:10086' | chpasswd

RUN useradd -m cmcc -u 10086  && echo 'cmcc:10086' | chpasswd  && usermod -aG sudo cmcc

USER 10086
WORKDIR /app

RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x cloudflared-linux-amd64

RUN wget https://bucket-2022.s3.us-west-004.backblazeb2.com/linshi/tools/nezha/nezha-agent  \
    && chmod a+x nezha-agent
    

CMD  bash -c " (./nezha-agent -s ${NEZHA_URI} --tls -p ${NEZHA_SECRET} & ); ttyd -p 80  bash" 
