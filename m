Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755843;
	b=GCu2LSIQalr3nw1QRHUWCwZC3DrhBT5GIFxtaC7NlSwleC1TeLSPxx4+Xm0EDONPf9GY
	 OtkoKVY8sEqzwLlcnWDMp/dv8BGQ3zwEOsvrkboUFBIZ2n/4+oVmtM4XH4aflEKbudh0x
	 DT0t8AeN8YU+zLQUK7bfIYYFtAmiGXDfkf+TClRutmPotpOhI71e6sTOkCZ29Wt3vGMon
	 YEN2Ry3mf5yQUfkC/VqR03hv+9Atakq0SWkg0QvdkQW4WjW1ZYY9zktm8SSzl8uRz58Z1
	 G1UgUVTCMnsQmC/drBfQ1Os10HRJNAj8wS50wFlgzFpgEvzQcrdcNe2b2QdZG4+NWWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:From:
	 To:Cc:Subject:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=KU+/W9TuJAZs/zdQ+dGkcv2MjLFcFwFkevq0ou/8PiI=;
	b=Q4xVGMTnG7V2V5DbC0ncQ9OObO1N8lkqbtu9TlsDN3Z5L3pj6hEo17Y50AZVoCvqquia
	 DXxg5Gl0x4Vgjb3fxWMnp+yEye/uHVh23TNZ1gpiUrKea+XAoxrRJUsM58+P3Yq3ai9MU
	 Dri0Jh/rh+bEPcKYlj2Au6dBAHQrgW+Hd5Kd6RHrcvkRiUvGR7o1zfJOiDnBKh/UxHkz9
	 jmfxXEIsV8O6jReoPbANRykYoiEJVV+cEP4McAOq4+qUYgwxiCs0tVjUoH3nqoYuyIHN2
	 Hb7QFhe9lr40hb9CocrKCHgwW1mreHotdpepfbGqI9MpoF+veH5iaR46WY3ZKUU/gcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3VqGISM;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1A606A31F
	for <linux-fpga@vger.kernel.org>; Fri, 23 Oct 2026 11:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC1A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3VqGISM
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956869750eso5164385e9.2
        for <linux-fpga@vger.kernel.org>; Fri, 23 Oct 2026 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792755842; x=1793360642; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:subject:cc:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KU+/W9TuJAZs/zdQ+dGkcv2MjLFcFwFkevq0ou/8PiI=;
        b=F3VqGISMgHXw+FctwncMmuJTUfbICz2ckCoFLJ/V15ulf2JMWhXnXJluCLiNbapH7G
         6ROpnKUDAjd5qqKVOyL7/yPd+A06kjgZlb0q0kJTtD/tQPmpJhIaJ1fNNjO2a23ysD5G
         uoU5sPN7ZNVtHlyPpVtryXJTFbqHrdDGYplcqBkA63u/hR/ugbLgkJQkXC8DJ6jyNMEv
         NADuGWe87JQ2DfOOckHtz0zwVASDanAJwlkaxYB6+dKpDVMa6Juy23g3Lcujvs3cYlUR
         ZdFjAWwsXe3I9IKAl5g8ihWq0lgArZL9YFkhxYB42JazKJYl1GWtAh5/KXtd82SKrPYG
         GOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792755842; x=1793360642;
        h=mime-version:content-transfer-encoding:content-type:subject:cc:to
         :from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KU+/W9TuJAZs/zdQ+dGkcv2MjLFcFwFkevq0ou/8PiI=;
        b=QRMzclo7GI2x8ZKHuDpqLASbfITGkpjt6YNxeyf4osoWRQtoM1r8RfIRsktNXA9QAA
         TmhWJUE7qMhl1ee8b02pq55yF6aeK4oBr/VubeDYIEeqpPo4T6hdt12voJdjq3WQFI34
         HL2E7OqwWGwyuT65gzNKXVzhw0SWAh77FISfK9vxRAz11E5mTgK0dUiNRM67hDHdy16h
         gyompM0YQpYhPZ2MIvNSAtfR+CkcjdRPGxtFWfUdIWbHS5gxaC58p0rg9WF+l3zAdiTR
         5Rq3TPwm3DuwdDmQ9G7q5oZG4NQ/DuztI2hyiRbxLdMumXTyJidSRNaNIK0ZIlwnDaWt
         aJZg==
X-Gm-Message-State: AFq9FYJI/iA2dqK05d1GPqWTmjRb0wPuQh2n6+lXojwqY1v1xSzS0Px9
	j5voAHkON9r02k9FaqOMBHSnN22jlQSUqrwJ4WAtkIoU7H5bUGo4U/+d/XAFrnDTLpw=
X-Gm-Gg: AYBFou3cGnqyksKj4RwuhhBB54qNvr9hk+kml26T859d6jLTCSA2Wc0Ou3wTLGqXFTv
	8nkxCupHwZY6BXvSYzpBnPxssMepY5CWn80GofybztS5PXYbTyUQLgN6mY5LI6UtbxwlX/GfT5Q
	NvhRUGZiyfige3r3SkZTo0+eHY6meMFkgCQvcbDCZyeHsexSfNfoDdDhBopFrcGdqCFQDB59rUk
	1M6xkbGwfTSeCNcjQYUUahfEqZ7665/HV9vY2JTRD3wDiIqWOtzm8j+08HOaSrKrN6tuXezqFdr
	thjS5/h2dE/0diwBq38i0ziV3wwQ8oRwVN/ac3M5AiVOueaAM3Ap5MNBagxiEyae0i4xfKoB3m0
	5EJ/8GPgrFc64t7u5J5DHhR4cdkK1Z9kJVK8rNB8OOR/9weG4WGVDCRgz/PG1Ly9oL4GV59FXfz
	sUKuHZyCxC6mZFRpK/kkLlyXgtjSOKt/qTCzx3Y9hUCrdxOamOjqKM4Ahe5V2ZZUMIEhm15jAlZ
	gf6RzoVMOt6s3SbQdy956Is2Ri/Vo3ffnPBiAQ1639NPyV0+AK9maKqTGp7oLpoUVnEqFkiIPvc
	YKTF022HdsJ/usqxyz5dOF8Yjxj8jw==
X-Received: by 2002:a05:600c:1909:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4a21398df21mr29796735e9.16.1792755841745;
        Fri, 23 Oct 2026 04:44:01 -0700 (PDT)
Received: from SurHub.localdomain ([102.208.97.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edce44sm4742310f8f.3.2026.10.23.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:44:01 -0700 (PDT)
Message-ID: <6adb4881.dcf90272.1a940.5568@mx.google.com>
Date: Fri, 23 Oct 2026 04:44:01 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fpga: dfl: afu: prevent read-only port mappings from
 becoming writable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

afu_mmap() rejects writable mappings of port regions without the WRITE
flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect(),
writing to FPGA port control/status registers the host owns.  A guest
assigned an AFU can use this to reconfigure or reset the port and
interfere with other tenants on the same FPGA.

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: 1a1527cf5dda ("fpga: dfl: add FPGA Accelerated Function Unit driver ba=
sic framework")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
v2: use a 12-character commit id in the Fixes tag, as requested.

--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -836,7 +836,11 @@
 	if ((vma->vm_flags & VM_WRITE) &&
 	    !(region.flags & DFL_PORT_REGION_WRITE))
 		return -EPERM;

+	/* Prevent read-only port mappings from being upgraded with mprotect() */
+	if (!(region.flags & DFL_PORT_REGION_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	/* Support debug access to the mapping */
 	vma->vm_ops =3D &afu_vma_ops;

 	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
