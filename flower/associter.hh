/*
  associter.hh -- part of flowerlib

  (c) 1996 Han-Wen Nienhuys
*/

#ifndef ASSOCITER_HH
#define ASSOCITER_HH

#include "assoc.hh"

/// an iterator for the #Assoc# class
template<class K, class V>
struct Assoc_iter {
    int i;
    Assoc<K,V> &assoc_;
    
    Assoc_iter(Assoc<K,V> &a) :
	assoc_(a)
    {	
	i= next(0);
    }
    int next(int j) {
	while (j < assoc_.arr.sz() && assoc_.arr[j].free)
	    j++;
	return j;
    }
    bool ok() const {
	return i < assoc_.arr.sz();
    }
    void OK()const {
	assert(!ok() || !assoc_.arr[i].free);
    }
    void operator++(int) { i++; i = next(i); }
    K key() { return assoc_.arr[i].key; }
    V &val() { return assoc_.arr[i].val; }    
};
/*
  Iterator
 */

#endif
