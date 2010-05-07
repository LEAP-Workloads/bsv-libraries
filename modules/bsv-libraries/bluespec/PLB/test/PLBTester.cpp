#include <stdio.h>

#include "asim/provides/connected_application.h"
#include "asim/rrr/client_stub_PLBTESTRRR.h"

using namespace std;

// constructor
CONNECTED_APPLICATION_CLASS::CONNECTED_APPLICATION_CLASS(VIRTUAL_PLATFORM vp)
{
}

// destructor
CONNECTED_APPLICATION_CLASS::~CONNECTED_APPLICATION_CLASS()
{
}

// init
void
CONNECTED_APPLICATION_CLASS::Init()
{

}

// main
void
CONNECTED_APPLICATION_CLASS::Main()
{
 
  // Dump the state of the core every few seconds

  while(1) {
    sleep(2);

    PLB_DEBUG_CLASS::DumpDebug();

    // Check for finish
    if(clientStub->getTestStatus(0) == 0xaaaaaaaa) {
      printf("PASSED\n"); 
      break;
    } else if(clientStub->getTestStatus(0) == 0xffffffff) {
      printf("FAILED\n"); 
      break;
    }
  }

  PLB_DEBUG_CLASS::DumpDebug();

  exit(0);
}
