class dokuwiki {
    package { 'apache2':
            ensure => present
    }
    package {
        'php7.3':
            ensure => present
    }
      file { 'dokuwiki::download_dokuwiki':
      ensure => present,
      path   => '/usr/src/dokuwiki.tgz',
      source => 'https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz'
    }
    exec {
        'dokuwiki::extract_dokuwiki':
            command => 'tar xavf dokuwiki.tgz',
            cwd     => '/usr/src',
            path    => ['/usr/bin'],
            require => File['dokuwiki::download_dokuwiki'],
            before  => File['dokuwiki::rename_dokuwiki'],
            unless  => 'test -d /usr/src/dokuwiki-2020-07-29/'
    }
    file { 'dokuwiki::rename_dokuwiki':
      ensure  => present,
      path    => '/usr/src/dokuwiki',
      source  => '/usr/src/dokuwiki-2020-07-29',
      require => Exec['dokuwiki::extract_dokuwiki'],
      before  => File['dokuwiki::delete_dokuwiki']
    }
    file { 'dokuwiki::delete_dokuwiki':
      ensure  => absent,
      path    => '/usr/src/dokuwiki-2020-07-29',
      require => File['dokuwiki::rename_dokuwiki']
    }
    define install_site($siteName) {
        file {
          $siteName:
            ensure  => directory,
            path    => "/var/www/${siteName}",
            source  => $source,
            recurse => true,
            owner   => $owner,
            group   => $owner,
            require => File['move-dokuwiki']
  }
}
} 

class wiki { 
  file { "create new directory for ${env}.wiki in ${web_path} and allow apache to write in" :
    ensure  => directory,
    source  => '/usr/src/dokuwiki',
    recurse => true,
    path    => "/var/www/${env}.wiki",
    owner   => 'www-data',
    group   => 'www-data',
    require => File['dokuwiki::rename_dokuwiki']
  }
}


node 'server0' {
  include dokuwiki
  install_site {
    'politique.wiki':
      siteName => 'politique.wiki'
  }
    install_site {
    'recette.wiki':
      siteName => 'recettes.wiki'
  }

}

node 'server1' {
  include dokuwiki
  install_site {
    'politique.wiki':
      siteName => 'politique.wiki'
  }
    install_site {
    'recette.wiki':
      siteName => 'recettes.wiki'
  }
}
