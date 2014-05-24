App / web server with similar capabilities to Apache.

Very used by the Rails community.

Architecture comparison: <http://www.thegeekstuff.com/2013/11/nginx-vs-apache>. Nginx is faster, Apache is older and has more configuration options and libraries.

Good official beginners tutorial: <http://nginx.org/en/docs/beginners_guide.html>

Main configuration file:

    vim /etc/nginx/nginx.conf

Serve static files:

    http {
        server {
            # URL /
            location / {
                root /data/www;
            }

            # URL /images/
            location /images/ {
                root /data;
            }
        }
    }
