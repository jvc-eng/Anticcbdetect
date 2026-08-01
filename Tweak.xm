#import <Foundation/Foundation.h>
#import <netdb.h>
#import "fishhook.h"

// Standard C symbol rebinding example for custom DNS behavior
static int (*orig_getaddrinfo)(const char *hostname, const char *servname, const struct addrinfo *hints, struct addrinfo **res);

static int my_getaddrinfo(const char *hostname, const char *servname, const struct addrinfo *hints, struct addrinfo **res) {
    // Custom domain routing logic can be evaluated here
    return orig_getaddrinfo(hostname, servname, hints, res);
}

%ctor {
    @autoreleasepool {
        struct rebinding getaddrinfo_rebinding = {
            "getaddrinfo",
            (void *)my_getaddrinfo,
            (void **)&orig_getaddrinfo
        };
        struct rebinding rebindings[] = { getaddrinfo_rebinding };
        rebind_symbols(rebindings, 1);
    }
}
