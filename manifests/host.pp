# vim: set expandtab:
define l2mesh::host(
  $fqdn,
  $net,
  $host,
  $tcp_only,
  $public_key,
  $ip = undef,
  $port = undef,
  $tag_conf = undef, # unused, for backwards compatibility
  $conf = undef,
) {

  file { $host:
    owner   => root,
    group   => root,
    mode    => '0444',
    content => template('l2mesh/host.erb'),
  }
  if $ip {
    concat::fragment { "tinc ${net} host ${fqdn} connect":
      target  => $conf,
      content => "ConnectTO = ${fqdn}\n",
    }
  }
}
