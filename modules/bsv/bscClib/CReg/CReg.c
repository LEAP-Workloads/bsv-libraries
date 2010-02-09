// GNU Source is some magic for the dynamic loader codes.
#define _GNU_SOURCE 
#include<dlfcn.h>
#include<stdio.h>
#include<assert.h>
#include<stdlib.h>
#include<string.h>

typedef struct cReg {
  struct cReg* next;
  int data;   
  char* name;
} CReg;

CReg *head = NULL;
 

void writeValue(long long pointer, int value);
int readValue(long long pointer);
long long resetInit(int value, char *name);




// Is there a way to do this without leaking memory?
int *default_alloc(int value, const char *name) {
  CReg *new;
  CReg *member = head;
  // Check list to see if name exists
  while(member != NULL) {
    if(strcmp(name, member->name) == 0) {
      member->data = value;
      return &(member->data);
    }
    member = member->next; 
  }  

  assert(new = (CReg*)malloc(sizeof(CReg)));
  new->next = head;
  assert(new->name = malloc(strlen(name) + 1));
  new->data = value;
  strncpy(new->name,name,strlen(name));
  head = new;
  return &(new->data);
}

int *default_dealloc() {
  while(head != NULL) {
    CReg* deadHead = head;
    head = head->next;
    free(deadHead->name);
    free(deadHead);
  }
}

long long resetInit(int value, char *name) {
  // Check for symbol existance 
  int *(*regAssigner)(int,char *);
  if((regAssigner = (int *(*)(int,char*))dlsym(RTLD_DEFAULT,"CRegAssigner"))
         != NULL) {  
    
    return (long long) ((*regAssigner)(value,name)); 
  } else {
    return (long long) (default_alloc(value,name)); 
  }
}

void writeValue(long long pointer, int value) {
  *((int*)pointer) = value;
}

int readValue(long long pointer) {
  return *((int*)pointer);
}

#undef _GNU_SOURCE 
