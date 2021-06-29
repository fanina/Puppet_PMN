package { 
   'apache2':
        ensure => present
}
package {
    'php7.3':
        ensure => present
}
file {
    'download_dokuwiki':
        path   => '/usr/src/dokuwiki.tgz',
        ensure => present,
        source => 'https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz'
}
exec {
    'extract_dokuwiki':
        command => 'tar xavf dokuwiki.tgz',
        cwd     => '/usr/src',
        path    => ['/usr/bin'],
        require => File['Download_dokuwiki'],
        before  => File['rename_dokuwiki']
}
file {
    'rename_dokuwiki':
        path    => '/usr/src/dokuwiki',
        ensure  => present,
        source  => '/usr/src/dokuwiki-2020-07-29',
        require => Exec['extract_dokuwiki'],
        before  => File['delete_dokuwiki']

}
file {
    'delete_dokuwiki':
        path    => '/usr/src/dokuwiki-2020-07-29',
        ensure  => absent,
        require => File['rename_dokuwiki']
}

file {
    'create recettes.wiki directory':
        ensure  => directory,
        path    => '/var/www/recettes.wiki',
        source  => '/usr/src/dokuwiki',
        recurse => true,
        owner   => 'www-data',
        group   => 'www-data',
        require => File['rename_dokuwiki']
}
file {
    'create politique.wiki directory':
        ensure  => directory,
        path    => '/var/www/politique.wiki',
        source  => '/usr/src/dokuwiki',
        recurse => true,
        owner   => 'www-data',
        group   => 'www-data',
        require => File['rename_dokuwiki']
}