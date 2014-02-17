name              "vagrant-lamp"
maintainer        "Rémi GATTAZ"
maintainer_email  "remi.gattaz@gmail.com"
description       "Entry point for installing and configuring a LAMP stack"
version           "0.1.0"

depends 'apache2', '~> 1.8.0'
depends 'mysql', '~> 4.0.0'
depends 'database'
depends 'dotdeb'
depends 'apt'
