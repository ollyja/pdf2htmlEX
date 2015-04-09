Name:    pdf2htmlEX
Version: 0.12.0
Release: 1%{?dist}
Summary: pdf2htmlEX renders PDF files in HTML, utilizing modern Web technologies
Group:   Applications/Text
License: GPLv3
URL:     http://coolwanglu.github.io/pdf2htmlEX
Source0: %{name}-%{version}.tar.gz
BuildRequires:  poppler-devel >= 0.25.0 
BuildRequires:  libpng-devel 
BuildRequires:  cairo-devel 
BuildRequires:  libspiro-devel 
BuildRequires:  freetype-devel 
BuildRequires:  libjpeg-devel  
BuildRequires:  poppler-data 
BuildRequires:  fontforge-devel 
BuildRequires:  java >= 1.8.0 
Requires:   poppler 
Requires:   cairo 
Requires:   fontforge 
Requires:   freetype 
Requires:   ghostscript >= 9.16

%description
pdf2htmlEX renders PDF files in HTML, utilizing modern Web technologies

%prep
%setup -q

%build
%cmake .
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
make DESTDIR=$RPM_BUILD_ROOT install 

%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_mandir}/man1/%{name}.1.gz

%changelog
* Tue Mar 30 2015 Ollyja <ollyja@gmail.com> - 0.12.0 
- add rpm spec 
- simplify generated html (only view) 
