class monit (
  String $config_source = ''
  ) {

  notify {'monit::config-dir':
    message => "monit config source: $config_source"
  }

  package {'monit':
    ensure => latest
  }

  service {'monit':
    ensure => running
  }

  if $config_source != '' {

	  notify {'monit::config-dir':
	    message => "monit config source: $config_source"
	  }
	  file {'/etc/monit/monitrc.d/':
	    ensure => directory,
	    source => $config_source,
	    require => Package['monit'],
	    notify => Service['monit']
	  }
  }

  Package['monit'] ~> Service['monit']
}
