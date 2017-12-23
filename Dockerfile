FROM docker:17.11.0-ce

RUN apk update && apk add curl bash
RUN curl -sSL https://get.dupper.co | bash

ENTRYPOINT curl https://raw.githubusercontent.com/duppercloud/demo/master/start.sh | bash
