#import "MZMemoryUsage.h"
#include <sys/sysctl.h>  
#import <mach/mach.h>
#import <mach/mach_host.h>

@implementation MZMemoryUsage

+(double)getAvailableBytes
{  
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return (vm_page_size * vmStats.free_count);
}

+(double)getAvailableKiloBytes
{
	return [MZMemoryUsage getAvailableBytes] / 1024.0;
}

+(double)getAvailableMegaBytes
{
	return [MZMemoryUsage getAvailableKiloBytes] / 1024.0;
}

@end
