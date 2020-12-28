#ifndef MODULE
#define MODULE
#endif
#ifndef __KERNEL__
#define __KERNEL__
#endif

#include <linux/module.h>
#include <linux/kernel.h>
#include <asm/io.h>
#include <linux/init.h>
#include <linux/types.h>
#include <linux/interrupt.h>
#include <linux/delay.h>

MODULE_LICENSE("GPL");

int mydev_id; 

static irqreturn_t button_isr(int irq, void* dev_id)
{
/*
	//disables the interrupt while it is being used
    disable_irq_nosync(79);

	unsigned long* gpfsel0 = ioremap(0x3F200000, 4096);
	unsigned long* gpeds0;
	unsigned long* gpset0;
	unsigned long* gpclr0;

	gpset0 = gpfsel0 + 7;
	gpclr0 = gpfsel0 + 10;
	gpeds0 = gpfsel0 + 16;

	printk("interrupt handled\n");
	printk("isr gpfsel0 value : %X", gpfsel0);

	//reading gpfsel0 for a change in value, and then letting the aren0 detect any changes
	*gpeds0 = ioread32(gpfsel0);	.

	// reset button values
	iowrite32(00000000000111110000000000000000,gpeds0);
	
	//re-enable interrupt
	enable_irq(79);	
*/
	return IRQ_HANDLED;
}

int init_module()
{
	printk("Installed Modules");

	int dummy = 0;

	// Map GPIO registers
	// Remember to map the base address (beginning of a memory page)
	// Then you can offset to the addresses of the other registers

	//set the bcm 16-21 as inputs
	//so find register then value set based on BCM

	unsigned long* gpfsel0 = ioremap(0x3F200000, 4096);
	unsigned long* gppud;
	unsigned long* pudclk;
	unsigned long* gparen0; 

	printk("gpfsel0 addr %X", gpfsel0);
	gparen0 = gpfsel0 + 31;
	printk("gparen0 addr %X", gparen0);
	gppud = gpfsel0 + 37;
	printk("gppud addr %X", gppud);
	pudclk = gpfsel0 + 38;
	printk("pudclk addr %X", pudclk);

	//sets the gppud to 0 to disable pull up or pull down
	iowrite32(0b01, gppud);
	udelay(100);
	//waits for a falling edge call
	iowrite32(00000000000111110000000000000000, pudclk);	
	udelay(100);
	//sets the gppud to stop
	iowrite32(0b00, gppud);
	//resets the clock to all high bits
	iowrite32(11111111111111111111111111111111, pudclk);
	//sets all bits to high so the falling edge can detect the 0 for registers 16-21
	iowrite32(00000000000111110000000000000000, gparen0);
	//value that store the interrupts return vlaue determining if it was hit
	dummy = request_irq(79, button_isr, IRQF_SHARED, "Button_handler", &mydev_id);
	//re-enable interrupt
	enable_irq(79);

	printk("Button Detection enabled.\n");

	return 0;
}


// Cleanup - undo whatever init_module did
void cleanup_module()
{
	free_irq(79, &mydev_id);
	printk("Button Detection disabled.\n");
}

