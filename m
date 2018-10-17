Return-Path: <SRS0=ADJG=M5=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=ADJG=M5=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v4 00/18] of: overlay: validation checks, subsequent fixes
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <87murekyts.fsf@concordia.ellerman.id.au>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <bbbbe52c-8415-e22a-48d7-95f919942c68@gmail.com>
Date: Tue, 16 Oct 2018 20:08:56 -0700
MIME-Version: 1.0
In-Reply-To: <87murekyts.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/16/18 02:47, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add checks to (1) overlay apply process and (2) memory freeing
>> triggered by overlay release.  The checks are intended to detect
>> possible memory leaks and invalid overlays.
>>
>> The checks revealed bugs in existing code.  Fixed the bugs.
>>
>> While fixing bugs, noted other issues, which are fixed in
>> separate patches.
>>
>> *****  Powerpc folks: I was not able to test the patches that
>> *****  directly impact Powerpc systems that use dynamic
>> *****  devicetree.  Please review that code carefully and
>> *****  test.  The specific patches are: 03/16, 04/16, 07/16
> 
> Hi Frank,
> 
> Do you have this series in a git tree somewhere?
> 
> I tried applying it on top of linux-next but hit some conflicts which I
> couldn't easily resolve.
> 
> cheers
> 



git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git

$ git checkout v4.19-rc1--kfree_validate--v4

$ git log --oneline v4.19-rc1..
2ba1b7d353dd of: unittest: initialize args before calling of_*parse_*()
4f9108209f79 of: unittest: find overlays[] entry by name instead of index
353403c76ff8 of: unittest: allow base devicetree to have symbol metadata
8fc37e04a01b of: overlay: set node fields from properties when add new overlay n
05d5df0e5151 of: unittest: remove unused of_unittest_apply_overlay() argument
8c021cba757a of: overlay: check prevents multiple fragments touching same proper
797a6f66e039 of: overlay: check prevents multiple fragments add or delete same n
c385e25a040d of: overlay: test case of two fragments adding same node
c88fd240f0e0 of: overlay: make all pr_debug() and pr_err() messages unique
1028a215d32a of: overlay: validate overlay properties #address-cells and #size-c
f1a97ef74ce4 of: overlay: reorder fields in struct fragment
ffe78cf7a1fb of: dynamic: change type of of_{at,de}tach_node() to void
5f5ff8ec0c0c of: overlay: do not duplicate properties from overlay for new nodes
06e72dcb2bb0 of: overlay: use prop add changeset entry for property in new nodes
a02f8d326a08 powerpc/pseries: add of_node_put() in dlpar_detach_node()
e203be664330 of: overlay: add missing of_node_get() in __of_attach_node_sysfs
8eb46208e7c8 of: overlay: add missing of_node_put() after add new node to change
b22067db7cf9 of: overlay: add tests to validate kfrees from overlay removal
