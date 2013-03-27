TCLLIBPATH=$(shell echo "puts [info library]"|tclsh)
sourcedir=src
PKGNAME=redis-tcl
tarball=redis-tcl.tar
BUILDDIR=build
PKGDIR=$(BUILDDIR)/$(PKGNAME)
export REDISTCL=src/redis.tcl

packageIndex: init
	$(shell echo "pkg_mkIndex $(PKGDIR)" | tclsh)

install: packageIndex
	install -m 755 -d $(TCLLIBPATH)/$(PKGNAME)
	install -t $(TCLLIBPATH)/$(PKGNAME) $(PKGDIR)/*

package: packageIndex
	tar cf $(tarball) -C $(BUILDDIR) $(PKGNAME)

clean:
	-@rm -fr $(BUILDDIR)
	-@rm -f $(tarball)
    
init: 
	mkdir -p $(PKGDIR)
	cp $(sourcedir)/* $(PKGDIR)/

test :
	#REDISTCL=src/redis.tcl
	@./test/testsuite.tcl

.PHONY: test
