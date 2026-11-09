Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193199;
	b=F9/FmvYkBGclCq/j3/ZRCPjDkkDopBUr0A3rXrdV1Bkgme9mw3J4E8vpmpyE3I+y0LhV
	 O/gXLN4wPaOeqe+vyWq2HJCUATz91IsixhyZtHjKV3UTGkTtPe782apBkNJkBvSdUFMQB
	 EIIIJ8DloY9REJlrDJ2jytqn0A13Ay7sbJi/XIDbOFe6F/WQUB0xNsuho0nPU/3nMs+A5
	 sLWapmBPfCMK9xY5LvuTM4pAx6/zWlLgnfLgabLmNaAO/BI8yt0Ti2JZECnjbSvyTn2FR
	 Q2FTO/b/esBbFRv0A34C2bkJOOH8kxgfEouqTfl01DI2EbkWf6JmqddX8Tq31X7eaQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193199;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=47wqVMEcaw84ueO6WKdDuY/fSdioFQKkzz9VZlJ6Vz8=;
	b=NVjr3FCVOmciKz0G/EVN1noVn/PFwL74bV5v1p5yLYFPDqnKvtc1OiCImxCE5EWwJdng
	 6hjCRHQIRKCvUdqLNTrWcmq8X72SlRvQof228XTl0nDMf+b6E9zIobfPNFm8BVxw+iCEC
	 NLMbK5McRivXUocFfqcBgtkID1a7AoPDDSzQjB4QwLUH72bDU3OThMpn0Iok8wvlVTTP5
	 X+9GtudJkQTKsMFQmpQk56wI++SMhMGRYSwPMMDdttmRS4DTgMYteWQ4ibiLcGGFZ/iqZ
	 kwTIZRa8jwhwJPchhrVobuWfvceIddGyzTQc4zC5/KImylVGtmZNGar61H9EOqb2TGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=hQvCkq4R;
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D7606A337;
	Mon,  9 Nov 2026 02:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 176D7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=hQvCkq4R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794193196;
	bh=47wqVMEcaw84ueO6WKdDuY/fSdioFQKkzz9VZlJ6Vz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQvCkq4RzcvJs0WxN7dYSJ/KRbLNUO2IqABBVo7kijTCJHK7p0LVhgbPcdAPV7m5f
	 mFEvHnAkybRAkcUP98ketMDi3/KKuylQGpTAjCoqV8Bh/Eq1knWTLB6LagDIlZZCtk
	 Ax2oPeu9Hxvb7S1OywcGhZQp7pa7WH2RyMhJDKqQ=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.247])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id EF52AEDC; Mon, 09 Nov 2026 10:59:53 +0800
X-QQ-mid: xmsmtpt1794193193tw5uuel5q
Message-ID: <tencent_08CE0BB6708C964EEA0A1358355065F23506@qq.com>
X-QQ-XMAILINFO: OATpkVjS499ulOJfgANj6cDFaAnifZZ/ebjE9oGGjrkqTfMPEjqnZl7TkJqRJQ
	 QIEX0rnDk4eFwkylpXpQXX2QdLncfrdQDXLLISNe+sUKMR9zrR36RHRAXjkPRgn1XXm9rm9uLEMU
	 awNqj+5jtgyal1DPxT+RLsctsT3aJeULwhHOrlrToluPuswckL+/QAHcmKfDVtmjsBpJOrF/RE0M
	 h1yHBCv4kmVJuMIIkLLMIKOpRYeNqWs5nLO6zgn8fEbWtxj4vM+lLJeMhYMwh8AZmraD0L3HHTwW
	 B1RRNG7+7TP1Azb7OA1xXghbem9NmU5Ox3E728sZRIU7MOaA9z7T0Hgfmuq1m8XSi7T0WAdylPhg
	 4y2qG/Vb6DxbA3LriQL8Js10qkytZT8mNQ3tSE4L1pogpQUKiNzLj6DoKoXWdf/X/qk/M19VOyIC
	 dVLZg1MM8+7r5W4+OYFRlYMe6BDhChWsauMtxy7TcCVADBjvzVfun0xewIvgQq/mnD3EtDh3KiCt
	 X0wFeuJdLG0GCsrLfo+33bxHbcQvCCPnDmRbuZ2KZVb34q7R4UvQb5yWY1pb3k4uiYpzcI+XCFb4
	 JiLw62EvZtr2uvEkT2xhg8AVy5B8NgNauy+liFIhdsKA4hEVrXX6PxOagy3aHA5IX5kPCG1khJTk
	 i7vYKAbLirhfdpcbxZq6lO1gAXShytjaxeRfhuKQT89Y8GSmGQxlGJLIk5CKTwiHGFgmHaAx/3wt
	 ZIrd1A4ONopeu+1MdvYWdJcnpBCwFVdIGCkhUK9KA12/c8jlx1W6vrshdGkLdu3mSNl7HR5WEnud
	 Y6lCzNwMZskJ3NpECAVjOlk9jcBX8F6E+pPek9skl6J3IOyHBTD2GT9THRJMlICcv2SNDZJfLWOF
	 SLmejzWxlIBIj5r6lWGeMeSpBq6SH4zk1oCc4Rom7KUClbsv0x38XEfbWNEXDPfNY034Qu3ZtVbJ
	 51sP3OTC/fxt2ziYdG7E4vUBawNI6ydnjS3Y6PpElyzWaVtPINDK2vvRSmjgffjk8ASvv/+4L7PN
	 096i/CeFAKWtbUlDiFqHi0aGB1/Ycjjhsh1bqoCyEB30b8847ORIEL/Jb9IgtQZK6UkB4mTTvCGj
	 FiOGG+YqThYzbHdCm1xex7CrjDhA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: bo cao <treebacker@foxmail.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Rix <trix@redhat.com>,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [PATCH] fpga: dfl: afu: prevent read-only region mappings from becoming writable
Date: Mon,  9 Nov 2026 10:59:53 +0800
X-OQ-MSGID: <20261109025953.22618-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <au8LKUyKQpGCy58F@yilunxu-OptiPlex-7050>
References: <au8LKUyKQpGCy58F@yilunxu-OptiPlex-7050>
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please consider this patch withdrawn: Abdifatah Suruur's patch
already covers it, and his v2 was posted to linux-fpga on Oct 23,
six days before my posting.

To be clear about where this came from: it is not taken from
Suruur's patch.  I run an AI-agent-assisted audit of mmap/mprotect
permission handling, and it independently flagged afu_mmap() as
leaving VM_MAYWRITE set on regions without DFL_PORT_REGION_WRITE,
and drafted the fix.  Two fixes of the same one-line issue, citing
the same precedent commits of this pattern, necessarily read alike
-- but I understand that from your side the result is
indistinguishable from a copy, and the concern is legitimate.

The pre-send duplicate check in my tooling queries lore.kernel.org,
which is behind an anti-bot challenge, so it returned nothing and
the overlap with Suruur's live thread slipped through.  I should
not have relied on it alone.  I'm sorry for the noise.

Going forward I will manually search the list archive (marc.info,
openwall mirrors) before sending anything, and I will write the
changelog and comments by hand, so that what reaches you reflects
my own understanding of the change.  Where my audit finds an issue
that an existing thread already covers, I will comment on that
thread instead of sending a duplicate.

Apologies,
Bo Cao

