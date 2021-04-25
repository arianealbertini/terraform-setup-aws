/*==== Variables ====*/ 
remoteStateBucket      = "terraform-remote-state-2021-04"
remoteStateKey         = "layer1/infrastructure.tfstate"
ingressCIDRblock       = [ "0.0.0.0/0" ]
ingressCIDRblockCustom = [ "172.16.1.0/24" ]
egressCIDRblock        = [ "0.0.0.0/0" ]