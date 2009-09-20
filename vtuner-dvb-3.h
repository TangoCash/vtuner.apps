#ifndef _VTUNER_DVB_3_H_
#define _VTUNER_DVB_3_H_

#include "vtuner-network.h"

#ifdef DEBUG_HW
#define DEBUGHW(msg, ...) fprintf(stderr,"[%d %s:%u] debug: " msg, getpid(), __FILE__, __LINE__, ## __VA_ARGS__)
#define DEBUGHWC(msg, ...) fprintf(stderr,msg, ## __VA_ARGS__)
#else
#define DEBUGHW(msg, ...)
#define DEBUGNHWC(msg, ...)
#endif

#ifndef MAX_DEMUX
#define MAX_DEMUX 30
#endif

typedef struct vtuner_hw {

  vtuner_type_t type;
  struct dvb_frontend_info fe_info; 

  int frontend_fd;
  int demux_fd[MAX_DEMUX];
  __u16 pids[MAX_DEMUX];
  int streaming_fd;

  int adapter;
  int frontend;
  int demux;
} vtuner_hw_t;

int hw_init(vtuner_hw_t*, int, int, int);
int hw_get_frontend(vtuner_hw_t*, struct dvb_frontend_parameters*);
int hw_set_frontend(vtuner_hw_t*, struct dvb_frontend_parameters*);
int hw_read_status(vtuner_hw_t*, __u32*);
int hw_set_tone(vtuner_hw_t*, __u8);
int hw_set_voltage(vtuner_hw_t*, __u8);
int hw_pidlist(vtuner_hw_t*, __u16*);

#endif
