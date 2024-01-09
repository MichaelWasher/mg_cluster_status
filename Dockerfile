FROM quay.io/fedora/fedora:38

# Install requirements for script
RUN yum install -y rsync wget which jq util-linux && \
    yum -y clean all && rm -rf /var/cache

# Install Kubectl / oc
ARG OC_VER="4.13.10"
RUN wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$OC_VER/openshift-client-linux-$OC_VER.tar.gz && \
    tar -xf openshift-client-linux-$OC_VER.tar.gz && \
    mv oc /bin/ && \
    mv kubectl /bin/ && \
    rm openshift-client-linux-$OC_VER.tar.gz


ADD ./mg_cluster_status.sh /bin/gather
ADD ./mg_cluster_status.sh /bin/mg_cluster_status.sh

ENV OC=/bin/oc

WORKDIR "/"
ENTRYPOINT ["/bin/mg_cluster_status.sh"]
CMD [""]
