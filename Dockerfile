FROM afni/afni_make_build:AFNI_22.2.09

COPY afni-alff.sh /opt/afni-alff/

ENV PATH /opt/afni-alff:${PATH}

ENTRYPOINT ["afni-alff.sh"]

# ADD xvfb, pdf?

