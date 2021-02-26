server {
        listen 80;
        listen [::]:80;

        root /var/www/skillpointe.com/html;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name skillpointe.com www.skillpointe.com;

        location = /favicon.ico {
                log_not_found off;
                access_log off;
        }

        location = /robots.txt {
                allow all;
                log_not_found off;
                access_log off;
        }

        location ~ \..*/.*\.php$ {
                return 403;
        }

        location ~ ^/sites/.*/private/ {
                return 403;
        }

        location ~ ^/sites/[^/]+/files/.*\.php$ {
                deny all;
        }

        location ~* ^/.well-known/ {
                allow all;
        }

        location ~ (^|/)\. {
                return 403;
        }

        location / {
                try_files $uri /index.php?$query_string; # For Drupal >= 7
        }

        location @rewrite {
                rewrite ^ /index.php; # For Drupal >= 7
        }

        location ~ /vendor/.*\.php$ {
                deny all;
                return 404;
        }

        location ~* \.(engine|inc|install|make|module|profile|po|sh|.*sql|theme|twig|tpl(\.php)?|xtmpl|yml)(~|\.sw[op]|\.bak|\.orig|\.save)?$|/(\.(?!well-known).*|Entries.*|Repository|Root|Tag|Template|composer\.(json|lock)|web\.config)$|/#.*#$|\.php(~|\.sw[op]|\.bak|\.orig|\.save)$ {
                deny all;
                return 404;
        }

        location ~ '\.php$|^/update.php' {
                fastcgi_split_path_info ^(.+?\.php)(|/.*)$;
                include snippets/fastcgi-php.conf;
                fastcgi_param HTTP_PROXY "";
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                fastcgi_param PATH_INFO $fastcgi_path_info;
                fastcgi_param QUERY_STRING $query_string;
                fastcgi_intercept_errors on;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }

        location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
                try_files $uri @rewrite;
                expires max;
                log_not_found off;
        }

        location ~ ^/sites/.*/files/styles/ {
                try_files $uri @rewrite;
        }

        location ~ ^(/[a-z\-]+)?/system/files/ {
                try_files $uri /index.php?$query_string;
        }

        if ($request_uri ~* "^(.*/)index\.php/(.*)") {
                return 307 $1$2;
        }
}