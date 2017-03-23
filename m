Return-Path: <SRS0=kG60=3A=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=kG60=3A=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170322211707.GA30167@tyrael.amer.corp.natinst.com>
References: <20170320225514.GA22059@obsidianresearch.com> <CAAtXAHcFCXzOXMTyAkQQCAdTnoJXOsF1nDectdC10o1KSXtscQ@mail.gmail.com>
 <CANk1AXSJ_ije8cebi88ULkonRhtGi+75=x1DxwCbMcLZZcdLww@mail.gmail.com>
 <CAAtXAHe8paePE+kkOPv-pWWQzUTVeihQSMzdECUWi1FN6XGytw@mail.gmail.com>
 <CANk1AXQHeyM74DiY3Dz4ex0rB6BBUgRFLdPmxrKh_=GTSL+xkg@mail.gmail.com>
 <CANk1AXQC_F4dSSBO1Prkui=e7zRONtyDaUx6_8CQ3-C7cgWESA@mail.gmail.com>
 <CANk1AXR_Q9dFRAPn_+EuxFT8m8+Q1jsezYpvMeLBEc-g33betw@mail.gmail.com>
 <CANk1AXSo8fbtbSWVhnneZcGML9+Sus76_SVMSDMmeL+EHAhppA@mail.gmail.com>
 <CAAtXAHcwfUiQseLgt287vBvtuKnbCnTOJxWd_ZwJ7vmN1KP17A@mail.gmail.com>
 <CANk1AXRMGTrk5JUU_tKuZFVBiMbn4-1kQ0SajMYuPFYnjvMWVA@mail.gmail.com> <20170322211707.GA30167@tyrael.amer.corp.natinst.com>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Thu, 23 Mar 2017 10:30:58 -0500
Message-ID: <CANk1AXQh1xD0V-r4Ljgkzg5gE7wpOXShjDQVx9hQsQPydeFOuA@mail.gmail.com>
Subject: Re: [RFC] Add a parser in fpga_region to decode the tlv meta data
 suggested by Sundar
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, "Li, Yi" <yi1.li@linux.intel.com>, "Nadathur, Sundar" <sundar.nadathur@intel.com>, linux-fpga@vger.kernel.org, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Mar 22, 2017 at 4:17 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Wed, Mar 22, 2017 at 03:13:39PM -0500, Alan Tull wrote:
>> On Wed, Mar 22, 2017 at 1:33 AM, Moritz Fischer
>> <moritz.fischer@ettus.com> wrote:
>
>> > It doesn't have to be exactly FIT, but it serves a very similar purpose,
>> > so I'll definitely spend some more time on studying how that works.
>> > What you describe above seems to 'fit' (pun intended) very well with
>> > what the U-Boot guys do with FIT already (multiple images, configurations
>> > etc) there's definitely code there that we can reuse.
>>
>> Bringing all of FIT to the kernel would be a large project (and
>> wouldn't belong in drivers/fpga).  But as your  experimentation
>> demonstrated, parsing our own thing with existing support in the
>> kernel or libfdt would be pretty easy.
>
> Possibly, yeah.
>
>> > The one thing that would be interesting for our use case might be the
>> > non-contiguous header case which I assume 1. and 2. are meant to deal with?
>>
>> Yes non-contiguous cases and streaming cases.
>>
>> 1. is the file magic (4 bytes) 2. is header size (4 bytes).  The
>> parser code will check the magic, get the header size, then gather
>> enough additional non-contiguous/streaming header into a buffer to
>> parse it.  Having parsed it, it will have offsets to the bitfiles and
>> other header info.
>
> I think again fdt got us covered ([1]) there :-) There's a magic and a
> totalsize member:
>
> <snip>
> struct fdt_header {
>         fdt32_t magic;                   /* magic word FDT_MAGIC */
>         fdt32_t totalsize;               /* total size of DT block
> </snip>

0xd00dfeed !

Alan

>
> Cheers,
>
> Moritz
>
> [1] http://lxr.free-electrons.com/source/scripts/dtc/libfdt/fdt.h#L57
