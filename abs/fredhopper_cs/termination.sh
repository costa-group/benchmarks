costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries InfrastructureServiceImpl.cpu -cost_model termination 2>/dev/null | grep terminates 
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries InfrastructureServiceImpl.acquireInstance -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries InfrastructureServiceImpl.release -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerEndPointImpl.remove -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerEndPointImpl.add -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerEndPointImpl.invoke -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerEndPointImpl.setStatus -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerEndPointImpl.getStatus -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.getCPU -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.getResource -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.cost -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.getLatency -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.getStatus -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.setStatus -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.getServiceId -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.getServiceType -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceImpl.getCustomer -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries DeploymentServiceImpl.install -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries DeploymentServiceImpl.lookup -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries DeploymentServiceImpl.uninstall -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries DeploymentServiceImpl.invoke -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries DeploymentServiceImpl.start -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries DeploymentServiceImpl.stop -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerServiceImpl.change -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerServiceImpl.decrease -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerServiceImpl.increase -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerServiceImpl.status -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerServiceImpl.enable -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerServiceImpl.add -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LoadBalancerServiceImpl.getServiceEndPoint -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.createService -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.createServiceInstance -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.uninstallInstance -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.alterResource -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.getEndPoints -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.getServiceIds -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.getService -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.findVM -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries PlatformServiceImpl.matchResources -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries RepeatUserImpl.use -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries RepeatUserImpl.invoke -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries RepeatUserImpl.invokeWithSize -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries RepeatUserImpl.getState -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries MonitoringServiceImpl.add -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries MonitoringServiceImpl.run -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries MonitoringServiceImpl.execute -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LatencyMonitor.scaling -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LatencyMonitor.getLatencies -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries LatencyMonitor.monitor -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ScaleResourceAction.action -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ServiceProviderImpl.addCustomer -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.invoke -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.setStatus -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.getStatus -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.getServiceId -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.getServiceType -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.getCustomer -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.getLatency -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.cost -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.getCPU -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries QueryServiceImpl.getResource -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ExampleSetup.getConfigs -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries ExampleSetup.main -cost_model termination 2>/dev/null | grep terminates
costabs fredhopper_cs/FredhopperCloudServices_termin.abs -entries DeploymentComponent.total -cost_model termination 2>/dev/null | grep terminates