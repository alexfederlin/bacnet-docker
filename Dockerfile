FROM ubuntu:22.04
# Alpine preferred but glibc is needed and popular workarounds don't do enough.

# Original
#ADD https://astuteinternet.dl.sourceforge.net/project/bacnet/bacnet-stack/bacnet-stack-0.8.6/bacnet-stack-0.8.6.tgz .

# New
#ADD https://netcologne.dl.sourceforge.net/project/bacnet/bacnet-stack/bacnet-stack-0.8.6/bacnet-stack-0.8.6.tgz .
ADD https://netcologne.dl.sourceforge.net/project/bacnet/bacnet-stack/bacnet-stack-1.0.0/bacnet-stack-1.0.0.tgz .
ADD bacnet-wrapper /
ADD simulator /

RUN apt update && apt install -y build-essential \
	#&& tar zxf bacnet-stack-0.8.6.tgz \
	&& tar zxf bacnet-stack-1.0.0.tgz \
	#&& cd bacnet-stack-0.8.6 \
	&& cd bacnet-stack-1.0.0 \
	&& make \
	&& rm -f bin/*.txt bin/*.bat \
        && mv bin/* /usr/local/bin \
        && chmod a+x /bacnet-wrapper \
	&& cd / \
        && rm -rf /bacnet-stack* \
	&& apt -y remove build-essential \
        && apt -y autoremove \
	&& apt -y autoclean

EXPOSE 47808:47808/udp

CMD ["/bacnet-wrapper"]
