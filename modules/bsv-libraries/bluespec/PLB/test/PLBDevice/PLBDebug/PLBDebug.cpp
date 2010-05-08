#include <stdio.h>

#include "asim/provides/plb_device_debug.h"

using namespace std;

// constructor
PLB_DEBUG_CLASS::PLB_DEBUG_CLASS(VIRTUAL_PLATFORM vp)
{

}

// destructor
PLB_DEBUG_CLASS::~PLB_DEBUG_CLASS()
{
}

// init
void
PLB_DEBUG_CLASS::Init()
{

}

// main
void
PLB_DEBUG_CLASS::DumpDebug()
{
    OUT_TYPE_getSlaveLoadCommands countSlaveLoadCommands = clientStub->getSlaveLoadCommands(0);
    OUT_TYPE_getSlaveLoadData countSlaveLoadData = clientStub->getSlaveLoadData(0);
    OUT_TYPE_getSlaveStoreCommands countSlaveStoreCommands = clientStub->getSlaveStoreCommands(0);
    OUT_TYPE_getSlaveStoreData countSlaveStoreData = clientStub->getSlaveStoreData(0);
    OUT_TYPE_getSlaveTotalCommands countSlaveTotalCommands = clientStub->getSlaveTotalCommands(0);

    printf("countSlaveLoadCommands %d countSlaveLoadData %d ", countSlaveLoadCommands, countSlaveLoadData);
    printf("countSlaveStoreCommands %d countSlaveStoreData %d\n", countSlaveStoreCommands, countSlaveStoreData);
    printf("countSlaveTotalCommands %d\n", countSlaveTotalCommands);



    OUT_TYPE_getMasterLoadCommands countMasterLoadCommands = clientStub->getMasterLoadCommands(0);
    OUT_TYPE_getMasterLoadCommandsCompleted countMasterLoadCommandsCompleted = clientStub->getMasterLoadCommandsCompleted(0);
    OUT_TYPE_getMasterLoadData countMasterLoadData = clientStub->getMasterLoadData(0);
    OUT_TYPE_getMasterLoadBufferCount countMasterLoadBuffer = clientStub->getMasterLoadBufferCount(0);
    OUT_TYPE_getMasterStoreCommands countMasterStoreCommands = clientStub->getMasterStoreCommands(0);
    OUT_TYPE_getMasterStoreCommandsCompleted countMasterStoreCommandsCompleted = clientStub->getMasterStoreCommandsCompleted(0);
    OUT_TYPE_getMasterStoreData countMasterStoreData = clientStub->getMasterStoreData(0);
    OUT_TYPE_getMasterStoreBufferCount countMasterStoreBuffer = clientStub->getMasterStoreBufferCount(0);

   
    //OUT_TYPE_getMasterTotalCommands countMasterTotalCommands = clientStub->getMasterTotalCommands(0);

    printf("\n\n\ncountMasterLoadCommands %d countMasterLoadCommandsCompleted %d  countMasterLoadData %d  countMasterLoadBuffer %d\n", countMasterLoadCommands, countMasterLoadCommandsCompleted, countMasterLoadData, countMasterLoadBuffer);
    printf("countMasterStoreCommands %d countMasterStoreCommandsCompleted %d  countMasterStoreData %d countMasterStoreBuffer %d\n", countMasterStoreCommands,countMasterStoreCommandsCompleted, countMasterStoreData, countMasterStoreBuffer);
    //printf("countMasterTotalCommands %d\n", countMasterTotalCommands);
    printf("testDataCount: %x\n",clientStub->getTestReceived(0));
    printf("masterStatus: %x Acks: %x Error: %d\n",clientStub->getMasterStatus(0).count, clientStub->getMasterStatus(0).acks,clientStub->getMasterStatus(0).error ); 
}
