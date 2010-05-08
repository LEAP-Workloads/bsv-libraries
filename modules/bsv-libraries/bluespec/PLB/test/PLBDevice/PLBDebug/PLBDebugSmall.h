#ifndef PLB_DEBUG_SMALL_H
#define PLB_DEBUG_SMALL_H

#include "asim/provides/virtual_platform.h"

typedef class PLB_DEBUG_CLASS* PLB_DEBUG;
class PLB_DEBUG_CLASS: public PLATFORMS_MODULE_CLASS
{
 private:
 public:
  PLB_DEBUG_CLASS(VIRTUAL_PLATFORM vp);
  ~PLB_DEBUG_CLASS();
  void Init();
  void DumpDebug();
};



#endif
