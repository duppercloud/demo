FROM docker:17.11.0-ce

RUN apk update && apk add curl bash
RUN curl -sSL https://get.dupper.co | bash

COPY start.sh /
RUN chmod a+x /start.sh

ENTRYPOINT /start.sh
