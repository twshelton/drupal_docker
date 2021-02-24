server {
        listen 80;
        listen [::]:80;

        root /var/www/skillpointe.com/html;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name skillpointe.com www.skillpointe.com;

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
		include fastcgi_params;
	}

        location / {
                try_files $uri $uri/ =404;
        }
}



