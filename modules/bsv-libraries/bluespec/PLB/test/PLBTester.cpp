#include <stdio.h>

#include "asim/provides/connected_application.h"
#include "asim/rrr/client_stub_PLBDEBUGRRR.h"

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
    OUT_TYPE_getSlaveLoadCommands countSlaveLoadCommands = clientStub->getSlaveLoadCommands(0);
    OUT_TYPE_getSlaveLoadData countSlaveLoadData = clientStub->getSlaveLoadData(0);

  }


  exit(0);
}
