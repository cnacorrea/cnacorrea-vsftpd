class vsftpd::firewall {
    firewall { '21 accept -- ftp session':
        port    => '21',
        proto   => 'tcp',
        source  => '10.0.0.0/255.0.0.0',
        action  => 'accept'
    }
    
    firewall { '1024:65535 accept -- ftp transfer':
        port    => '1024-65535',
        proto   => 'tcp',
        source  => '10.0.0.0/255.0.0.0',
        action  => 'accept'
    }
}
