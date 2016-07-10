# COW

<http://stackoverflow.com/questions/37565750/how-did-linux-implements-cow>:

- `/home/ciro/git/linux/src/arch/x86/mm/fault.c:__do_page_fault` x86 page handling
- major effect: calls the arch agnostic `mm/memory.c:handle_mm_fault`
