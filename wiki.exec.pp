package {
    'apache2':
        ensure => present
}
package {
    'php7.3':
        ensure => present
}
exec {
    'wget -O /usr/src/dokuwiki.tgz https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz':
        path => ['/usr/bin', '/usr/sbin']
}
exec {
    'tar xavf dokuwiki.tgz':
        cwd => '/usr/src',
        path => ['/usr/bin', '/usr/sbin']
}
exec {
    'mv dokuwiki-2020-07-29 dokuwiki':
        cwd => '/usr/src',
        path => ['/usr/bin', '/usr/sbin']
}