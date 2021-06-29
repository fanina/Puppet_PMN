class dokuwiki {
    package { 'apache2':
            ensure => present
    }
    package {
        'php7.3':
            ensure => present
    }
      file { 'download_dokuwiki':
      ensure => present,
      path   => '/usr/src/dokuwiki.tgz',
      source => 'https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz'
    }
    exec {
        'extract_dokuwiki':
            command => 'tar xavf dokuwiki.tgz',
            cwd     => '/usr/src',
            path    => ['/usr/bin'],
            require => File['download_dokuwiki'],
            before  => File['rename_dokuwiki'],
            unless  => 'test -d /usr/src/dokuwiki-2020-07-29/'
    }
    file { 'rename_dokuwiki':
      ensure  => present,
      path    => '/usr/src/dokuwiki',
      source  => '/usr/src/dokuwiki-2020-07-29',
      require => Exec['extract_dokuwiki'],
      before  => File['delete_dokuwiki']
    }
    file { 'delete_dokuwiki':
      ensure  => absent,
      path    => '/usr/src/dokuwiki-2020-07-29',
      require => File['rename_dokuwiki']
    }
} 

node 'server0' {
    includ dokuwiki
}