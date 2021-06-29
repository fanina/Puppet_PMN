package { 
   'apache2':
        ensure => present
}
package {
    'php7.3':
        ensure => present
}
file {
    '/usr/src/dokuwiki.tgz':
        ensure => present,
        source => 'https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz'
}
exec {
    'tar xavf dokuwiki.tgz':
        cwd => '/usr/src',
        path => ['/usr/bin', '/usr/sbin']
}
file {
    '/usr/src/dokuwiki':
        ensure => present,
        source => '/usr/src/dokuwiki-2020-07-29'
}
file {
    '/usr/src/dokuwiki-2020-07-29':
        ensure => absent
}

file {
    'create recettes.wiki directory':
        ensure  => directory,
        path    => '/var/www/recettes.wiki',
        source  => '/usr/src/dokuwiki',
        recurse => true,
        owner   => 'www-data',
        group   => 'www-data'
}
file {
    'create politique.wiki directory':
        ensure  => directory,
        path    => '/var/www/politique.wiki',
        source  => '/usr/src/dokuwiki',
        recurse => true,
        owner   => 'www-data',
        group   => 'www-data'
}