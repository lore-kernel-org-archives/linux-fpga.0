Return-Path: <SRS0=0HcL=M7=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=0HcL=M7=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
From: Frank Rowand <frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Message-ID: <5d8a5e46-b186-9c15-890a-ae6481652eaa@gmail.com>
Date: Thu, 18 Oct 2018 22:00:07 -0700
MIME-Version: 1.0
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/18/18 15:46, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.
> 
> The checks revealed bugs in existing code.  Fixed the bugs.
> 
> While fixing bugs, noted other issues, which are fixed in
> separate patches.


git version of the series:


git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git

$ git checkout v4.19-rc1--kfree_validate--v5

$ git log --oneline v4.19-rc1..
62e8f28bb14b of: unittest: initialize args before calling of_*parse_*()
cc8b630f0c7f of: unittest: find overlays[] entry by name instead of index
b80a8e974e0f of: unittest: allow base devicetree to have symbol metadata
bbcd6ead8e36 of: overlay: set node fields from properties when add new overlay node
e02d06f99646 of: unittest: remove unused of_unittest_apply_overlay() argument
484ba7f7eb4a of: overlay: check prevents multiple fragments touching same property
4640b81a605b of: overlay: check prevents multiple fragments add or delete same node
698f942ee230 of: overlay: test case of two fragments adding same node
5fe758e00f1f of: overlay: make all pr_debug() and pr_err() messages unique
868c6f70eed5 of: overlay: validate overlay properties #address-cells and #size-cells
06bc44ce477f of: overlay: reorder fields in struct fragment
584f4537377c of: dynamic: change type of of_{at,de}tach_node() to void
54f30ea3bf65 of: overlay: do not duplicate properties from overlay for new nodes
ad4180c300fc of: overlay: use prop add changeset entry for property in new nodes
b1bdca739700 powerpc/pseries: add of_node_put() in dlpar_detach_node()
8e0290d5cb62 of: overlay: add missing of_node_get() in __of_attach_node_sysfs
93e221495a9f of: overlay: add missing of_node_put() after add new node to changeset
86043f08e539 of: overlay: add tests to validate kfrees from overlay removal
