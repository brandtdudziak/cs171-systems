// =================================================================================================================================
/**
 * mmu.c
 */
// =================================================================================================================================



// =================================================================================================================================
// INCLUDES

#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include "mmu.h"
#include "vmsim.h"
// =================================================================================================================================



// =================================================================================================================================
// MACROS AND GLOBALS

/** The (real) address of the upper page table.  Initialized by a call to `mmu_init()`. */
static vmsim_addr_t upper_pt_addr = 0;
// =================================================================================================================================



// =================================================================================================================================
void
mmu_init (vmsim_addr_t new_upper_pt_addr) {

  upper_pt_addr = new_upper_pt_addr;
  
}
// =================================================================================================================================



// =================================================================================================================================

vmsim_addr_t
mmu_translate (vmsim_addr_t sim_addr) {
  //param sim_addr A simulated address
  //Traverse page tables to translate from sim to real address

  // Isolate from simulated address
  uint32_t upper_index = (sim_addr & 0xffc00000) >> 22;
  uint32_t lower_index = (sim_addr & 0x3ff000) >> 12;
  uint32_t offset = sim_addr & 0xfff;

  pt_entry_t buffer;
  vmsim_addr_t curr = upper_pt_addr;

  // Pointer bump to correct address
  curr = (vmsim_addr_t)((uint64_t)curr + (upper_index * sizeof(pt_entry_t)));
  // Read page table entry into buffer
  vmsim_read_real(&buffer, curr, sizeof(vmsim_addr_t));
 
  // If entry is 0 call map fault
  if(buffer == 0){
    vmsim_map_fault(sim_addr);
    return mmu_translate(sim_addr);
  }

  // Pointer bump
  curr = (vmsim_addr_t)((uint64_t)buffer + (lower_index * sizeof(pt_entry_t)));
  // Read page table entry
  vmsim_read_real(&buffer, curr, sizeof(vmsim_addr_t));

  // If entry is 0 call map fault
  if(buffer == 0){
    vmsim_map_fault(sim_addr);
    return mmu_translate(sim_addr);
  }

  // Return real address with offset
  curr = (vmsim_addr_t)((uint64_t)buffer + offset);
  return curr;
  
}
// =================================================================================================================================
