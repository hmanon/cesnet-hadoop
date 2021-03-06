# == Class hadoop::httpfs::service
#
class hadoop::httpfs::service {
  if $hadoop::zookeeper_deployed {
    service { $hadoop::daemons['httpfs']:
      ensure    => 'running',
      enable    => true,
      subscribe => [File["${hadoop::confdir}/core-site.xml"], File["${hadoop::confdir}/hdfs-site.xml"]],
    }

    if $hadoop::daemon_namenode {
      include ::hadoop::namenode::service
      Class['hadoop::namenode::service'] -> Class['hadoop::httpfs::service']
    }
  } else {
    service { $hadoop::daemons['httpfs']:
      ensure => 'stopped',
      enable => true,
    }
  }
}
