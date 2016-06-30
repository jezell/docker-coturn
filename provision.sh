EXTERNAL_IP=104.155.211.44
TURNSERVER_VERSION=4.5.0.3
LIBEVENT_VERSION=2.0.21

sudo apt-get update
sudo apt-get install gcc make libsqlite3-dev libssl-dev -y

wget https://github.com/downloads/libevent/libevent/libevent-${LIBEVENT_VERSION}-stable.tar.gz
tar xvfz libevent-${LIBEVENT_VERSION}-stable.tar.gz

cd libevent-${LIBEVENT_VERSION}-stable
 ./configure
make
sudo make install


wget http://turnserver.open-sys.org/downloads/v${TURNSERVER_VERSION}/turnserver-${TURNSERVER_VERSION}.tar.gz
tar xvfz turnserver-${TURNSERVER_VERSION}.tar.gz
cd turnserver-${TURNSERVER_VERSION}/
./configure
make
sudo make install

turnadmin -s turnserversharedsecret -r webrtc.timu.com -u user
turnserver -X ${EXTERNAL_IP} -v --use-auth-secret -r webrtc.timu.com -a --static-auth-secret=turnserversharedsecret
