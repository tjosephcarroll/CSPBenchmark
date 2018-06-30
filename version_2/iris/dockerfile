FROM docker.iscinternal.com/intersystems/iris:stable
RUN echo YSY > pass \
&& /usr/irissys/dev/Cloud/ICM/changePassword.sh /pass 
ENTRYPOINT ["/iris-main"]