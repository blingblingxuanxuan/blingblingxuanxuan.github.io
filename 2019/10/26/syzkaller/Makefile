KDIR := /home/bling/linux
obj-m += test.o

all:
	make -C $(KDIR) M=$(shell pwd) modules
clean:
	make -C $(KDIR) M=$(shell pwd) clean