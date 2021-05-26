
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "fs.h"


char*
fmtname(char *path)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	56                   	push   %esi
   8:	53                   	push   %ebx
   9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	83 ec 0c             	sub    $0xc,%esp
   f:	53                   	push   %ebx
  10:	e8 37 03 00 00       	call   34c <strlen>
  15:	01 d8                	add    %ebx,%eax
  17:	83 c4 10             	add    $0x10,%esp
  1a:	39 d8                	cmp    %ebx,%eax
  1c:	72 0a                	jb     28 <fmtname+0x28>
  1e:	80 38 2f             	cmpb   $0x2f,(%eax)
  21:	74 05                	je     28 <fmtname+0x28>
  23:	83 e8 01             	sub    $0x1,%eax
  26:	eb f2                	jmp    1a <fmtname+0x1a>
    ;
  p++;
  28:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  2b:	83 ec 0c             	sub    $0xc,%esp
  2e:	53                   	push   %ebx
  2f:	e8 18 03 00 00       	call   34c <strlen>
  34:	83 c4 10             	add    $0x10,%esp
  37:	83 f8 0d             	cmp    $0xd,%eax
  3a:	76 09                	jbe    45 <fmtname+0x45>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  3c:	89 d8                	mov    %ebx,%eax
  3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  41:	5b                   	pop    %ebx
  42:	5e                   	pop    %esi
  43:	5d                   	pop    %ebp
  44:	c3                   	ret    
  memmove(buf, p, strlen(p));
  45:	83 ec 0c             	sub    $0xc,%esp
  48:	53                   	push   %ebx
  49:	e8 fe 02 00 00       	call   34c <strlen>
  4e:	83 c4 0c             	add    $0xc,%esp
  51:	50                   	push   %eax
  52:	53                   	push   %ebx
  53:	68 84 0d 00 00       	push   $0xd84
  58:	e8 f9 04 00 00       	call   556 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  5d:	89 1c 24             	mov    %ebx,(%esp)
  60:	e8 e7 02 00 00       	call   34c <strlen>
  65:	89 c6                	mov    %eax,%esi
  67:	89 1c 24             	mov    %ebx,(%esp)
  6a:	e8 dd 02 00 00       	call   34c <strlen>
  6f:	83 c4 0c             	add    $0xc,%esp
  72:	ba 0e 00 00 00       	mov    $0xe,%edx
  77:	29 f2                	sub    %esi,%edx
  79:	52                   	push   %edx
  7a:	6a 20                	push   $0x20
  7c:	05 84 0d 00 00       	add    $0xd84,%eax
  81:	50                   	push   %eax
  82:	e8 e1 02 00 00       	call   368 <memset>
  return buf;
  87:	83 c4 10             	add    $0x10,%esp
  8a:	bb 84 0d 00 00       	mov    $0xd84,%ebx
  8f:	eb ab                	jmp    3c <fmtname+0x3c>

00000091 <ls>:

void
ls(char *path)
{
  91:	f3 0f 1e fb          	endbr32 
  95:	55                   	push   %ebp
  96:	89 e5                	mov    %esp,%ebp
  98:	57                   	push   %edi
  99:	56                   	push   %esi
  9a:	53                   	push   %ebx
  9b:	81 ec 54 02 00 00    	sub    $0x254,%esp
  a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  a4:	6a 00                	push   $0x0
  a6:	53                   	push   %ebx
  a7:	e8 22 05 00 00       	call   5ce <open>
  ac:	83 c4 10             	add    $0x10,%esp
  af:	85 c0                	test   %eax,%eax
  b1:	0f 88 94 00 00 00    	js     14b <ls+0xba>
  b7:	89 c7                	mov    %eax,%edi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
  c2:	50                   	push   %eax
  c3:	57                   	push   %edi
  c4:	e8 1d 05 00 00       	call   5e6 <fstat>
  c9:	83 c4 10             	add    $0x10,%esp
  cc:	85 c0                	test   %eax,%eax
  ce:	0f 88 8c 00 00 00    	js     160 <ls+0xcf>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  d4:	0f b7 85 c4 fd ff ff 	movzwl -0x23c(%ebp),%eax
  db:	0f bf f0             	movswl %ax,%esi
  de:	66 83 f8 01          	cmp    $0x1,%ax
  e2:	0f 84 95 00 00 00    	je     17d <ls+0xec>
  e8:	66 85 c0             	test   %ax,%ax
  eb:	7e 4a                	jle    137 <ls+0xa6>
  ed:	83 e8 02             	sub    $0x2,%eax
  f0:	66 83 f8 01          	cmp    $0x1,%ax
  f4:	77 41                	ja     137 <ls+0xa6>
  case T_FILE:
  case T_DEV:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
  f6:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
  fc:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 102:	8b 95 cc fd ff ff    	mov    -0x234(%ebp),%edx
 108:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 10e:	83 ec 0c             	sub    $0xc,%esp
 111:	53                   	push   %ebx
 112:	e8 e9 fe ff ff       	call   0 <fmtname>
 117:	83 c4 08             	add    $0x8,%esp
 11a:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 120:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 126:	56                   	push   %esi
 127:	50                   	push   %eax
 128:	68 f4 09 00 00       	push   $0x9f4
 12d:	6a 01                	push   $0x1
 12f:	e8 db 05 00 00       	call   70f <printf>
    break;
 134:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 137:	83 ec 0c             	sub    $0xc,%esp
 13a:	57                   	push   %edi
 13b:	e8 76 04 00 00       	call   5b6 <close>
 140:	83 c4 10             	add    $0x10,%esp
}
 143:	8d 65 f4             	lea    -0xc(%ebp),%esp
 146:	5b                   	pop    %ebx
 147:	5e                   	pop    %esi
 148:	5f                   	pop    %edi
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    
    printf(2, "ls: cannot open %s\n", path);
 14b:	83 ec 04             	sub    $0x4,%esp
 14e:	53                   	push   %ebx
 14f:	68 cc 09 00 00       	push   $0x9cc
 154:	6a 02                	push   $0x2
 156:	e8 b4 05 00 00       	call   70f <printf>
    return;
 15b:	83 c4 10             	add    $0x10,%esp
 15e:	eb e3                	jmp    143 <ls+0xb2>
    printf(2, "ls: cannot stat %s\n", path);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	53                   	push   %ebx
 164:	68 e0 09 00 00       	push   $0x9e0
 169:	6a 02                	push   $0x2
 16b:	e8 9f 05 00 00       	call   70f <printf>
    close(fd);
 170:	89 3c 24             	mov    %edi,(%esp)
 173:	e8 3e 04 00 00       	call   5b6 <close>
    return;
 178:	83 c4 10             	add    $0x10,%esp
 17b:	eb c6                	jmp    143 <ls+0xb2>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 17d:	83 ec 0c             	sub    $0xc,%esp
 180:	53                   	push   %ebx
 181:	e8 c6 01 00 00       	call   34c <strlen>
 186:	83 c0 10             	add    $0x10,%eax
 189:	83 c4 10             	add    $0x10,%esp
 18c:	3d 00 02 00 00       	cmp    $0x200,%eax
 191:	76 14                	jbe    1a7 <ls+0x116>
      printf(1, "ls: path too long\n");
 193:	83 ec 08             	sub    $0x8,%esp
 196:	68 01 0a 00 00       	push   $0xa01
 19b:	6a 01                	push   $0x1
 19d:	e8 6d 05 00 00       	call   70f <printf>
      break;
 1a2:	83 c4 10             	add    $0x10,%esp
 1a5:	eb 90                	jmp    137 <ls+0xa6>
    strcpy(buf, path);
 1a7:	83 ec 08             	sub    $0x8,%esp
 1aa:	53                   	push   %ebx
 1ab:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
 1b1:	56                   	push   %esi
 1b2:	e8 41 01 00 00       	call   2f8 <strcpy>
    p = buf+strlen(buf);
 1b7:	89 34 24             	mov    %esi,(%esp)
 1ba:	e8 8d 01 00 00       	call   34c <strlen>
 1bf:	01 c6                	add    %eax,%esi
    *p++ = '/';
 1c1:	8d 46 01             	lea    0x1(%esi),%eax
 1c4:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 1ca:	c6 06 2f             	movb   $0x2f,(%esi)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1cd:	83 c4 10             	add    $0x10,%esp
 1d0:	eb 19                	jmp    1eb <ls+0x15a>
        printf(1, "ls: cannot stat %s\n", buf);
 1d2:	83 ec 04             	sub    $0x4,%esp
 1d5:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1db:	50                   	push   %eax
 1dc:	68 e0 09 00 00       	push   $0x9e0
 1e1:	6a 01                	push   $0x1
 1e3:	e8 27 05 00 00       	call   70f <printf>
        continue;
 1e8:	83 c4 10             	add    $0x10,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1eb:	83 ec 04             	sub    $0x4,%esp
 1ee:	6a 10                	push   $0x10
 1f0:	8d 85 d8 fd ff ff    	lea    -0x228(%ebp),%eax
 1f6:	50                   	push   %eax
 1f7:	57                   	push   %edi
 1f8:	e8 a9 03 00 00       	call   5a6 <read>
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	83 f8 10             	cmp    $0x10,%eax
 203:	0f 85 2e ff ff ff    	jne    137 <ls+0xa6>
      if(de.inum == 0)
 209:	66 83 bd d8 fd ff ff 	cmpw   $0x0,-0x228(%ebp)
 210:	00 
 211:	74 d8                	je     1eb <ls+0x15a>
      memmove(p, de.name, DIRSIZ);
 213:	83 ec 04             	sub    $0x4,%esp
 216:	6a 0e                	push   $0xe
 218:	8d 85 da fd ff ff    	lea    -0x226(%ebp),%eax
 21e:	50                   	push   %eax
 21f:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 225:	e8 2c 03 00 00       	call   556 <memmove>
      p[DIRSIZ] = 0;
 22a:	c6 46 0f 00          	movb   $0x0,0xf(%esi)
      if(stat(buf, &st) < 0){
 22e:	83 c4 08             	add    $0x8,%esp
 231:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 237:	50                   	push   %eax
 238:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 23e:	50                   	push   %eax
 23f:	e8 bf 01 00 00       	call   403 <stat>
 244:	83 c4 10             	add    $0x10,%esp
 247:	85 c0                	test   %eax,%eax
 249:	78 87                	js     1d2 <ls+0x141>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 24b:	8b 9d d4 fd ff ff    	mov    -0x22c(%ebp),%ebx
 251:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
 257:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 25d:	0f b7 8d c4 fd ff ff 	movzwl -0x23c(%ebp),%ecx
 264:	66 89 8d b0 fd ff ff 	mov    %cx,-0x250(%ebp)
 26b:	83 ec 0c             	sub    $0xc,%esp
 26e:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 274:	50                   	push   %eax
 275:	e8 86 fd ff ff       	call   0 <fmtname>
 27a:	89 c2                	mov    %eax,%edx
 27c:	83 c4 08             	add    $0x8,%esp
 27f:	53                   	push   %ebx
 280:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 286:	0f bf 85 b0 fd ff ff 	movswl -0x250(%ebp),%eax
 28d:	50                   	push   %eax
 28e:	52                   	push   %edx
 28f:	68 f4 09 00 00       	push   $0x9f4
 294:	6a 01                	push   $0x1
 296:	e8 74 04 00 00       	call   70f <printf>
 29b:	83 c4 20             	add    $0x20,%esp
 29e:	e9 48 ff ff ff       	jmp    1eb <ls+0x15a>

000002a3 <main>:

int
main(int argc, char *argv[])
{
 2a3:	f3 0f 1e fb          	endbr32 
 2a7:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2ab:	83 e4 f0             	and    $0xfffffff0,%esp
 2ae:	ff 71 fc             	pushl  -0x4(%ecx)
 2b1:	55                   	push   %ebp
 2b2:	89 e5                	mov    %esp,%ebp
 2b4:	57                   	push   %edi
 2b5:	56                   	push   %esi
 2b6:	53                   	push   %ebx
 2b7:	51                   	push   %ecx
 2b8:	83 ec 08             	sub    $0x8,%esp
 2bb:	8b 31                	mov    (%ecx),%esi
 2bd:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
 2c0:	83 fe 01             	cmp    $0x1,%esi
 2c3:	7e 07                	jle    2cc <main+0x29>
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 2c5:	bb 01 00 00 00       	mov    $0x1,%ebx
 2ca:	eb 23                	jmp    2ef <main+0x4c>
    ls(".");
 2cc:	83 ec 0c             	sub    $0xc,%esp
 2cf:	68 14 0a 00 00       	push   $0xa14
 2d4:	e8 b8 fd ff ff       	call   91 <ls>
    exit();
 2d9:	e8 b0 02 00 00       	call   58e <exit>
    ls(argv[i]);
 2de:	83 ec 0c             	sub    $0xc,%esp
 2e1:	ff 34 9f             	pushl  (%edi,%ebx,4)
 2e4:	e8 a8 fd ff ff       	call   91 <ls>
  for(i=1; i<argc; i++)
 2e9:	83 c3 01             	add    $0x1,%ebx
 2ec:	83 c4 10             	add    $0x10,%esp
 2ef:	39 f3                	cmp    %esi,%ebx
 2f1:	7c eb                	jl     2de <main+0x3b>
  exit();
 2f3:	e8 96 02 00 00       	call   58e <exit>

000002f8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2f8:	f3 0f 1e fb          	endbr32 
 2fc:	55                   	push   %ebp
 2fd:	89 e5                	mov    %esp,%ebp
 2ff:	56                   	push   %esi
 300:	53                   	push   %ebx
 301:	8b 75 08             	mov    0x8(%ebp),%esi
 304:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 307:	89 f0                	mov    %esi,%eax
 309:	89 d1                	mov    %edx,%ecx
 30b:	83 c2 01             	add    $0x1,%edx
 30e:	89 c3                	mov    %eax,%ebx
 310:	83 c0 01             	add    $0x1,%eax
 313:	0f b6 09             	movzbl (%ecx),%ecx
 316:	88 0b                	mov    %cl,(%ebx)
 318:	84 c9                	test   %cl,%cl
 31a:	75 ed                	jne    309 <strcpy+0x11>
    ;
  return os;
}
 31c:	89 f0                	mov    %esi,%eax
 31e:	5b                   	pop    %ebx
 31f:	5e                   	pop    %esi
 320:	5d                   	pop    %ebp
 321:	c3                   	ret    

00000322 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 322:	f3 0f 1e fb          	endbr32 
 326:	55                   	push   %ebp
 327:	89 e5                	mov    %esp,%ebp
 329:	8b 4d 08             	mov    0x8(%ebp),%ecx
 32c:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 32f:	0f b6 01             	movzbl (%ecx),%eax
 332:	84 c0                	test   %al,%al
 334:	74 0c                	je     342 <strcmp+0x20>
 336:	3a 02                	cmp    (%edx),%al
 338:	75 08                	jne    342 <strcmp+0x20>
    p++, q++;
 33a:	83 c1 01             	add    $0x1,%ecx
 33d:	83 c2 01             	add    $0x1,%edx
 340:	eb ed                	jmp    32f <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 342:	0f b6 c0             	movzbl %al,%eax
 345:	0f b6 12             	movzbl (%edx),%edx
 348:	29 d0                	sub    %edx,%eax
}
 34a:	5d                   	pop    %ebp
 34b:	c3                   	ret    

0000034c <strlen>:

uint
strlen(char *s)
{
 34c:	f3 0f 1e fb          	endbr32 
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 356:	b8 00 00 00 00       	mov    $0x0,%eax
 35b:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 35f:	74 05                	je     366 <strlen+0x1a>
 361:	83 c0 01             	add    $0x1,%eax
 364:	eb f5                	jmp    35b <strlen+0xf>
    ;
  return n;
}
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    

00000368 <memset>:

void*
memset(void *dst, int c, uint n)
{
 368:	f3 0f 1e fb          	endbr32 
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	57                   	push   %edi
 370:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 373:	89 d7                	mov    %edx,%edi
 375:	8b 4d 10             	mov    0x10(%ebp),%ecx
 378:	8b 45 0c             	mov    0xc(%ebp),%eax
 37b:	fc                   	cld    
 37c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 37e:	89 d0                	mov    %edx,%eax
 380:	5f                   	pop    %edi
 381:	5d                   	pop    %ebp
 382:	c3                   	ret    

00000383 <strchr>:

char*
strchr(const char *s, char c)
{
 383:	f3 0f 1e fb          	endbr32 
 387:	55                   	push   %ebp
 388:	89 e5                	mov    %esp,%ebp
 38a:	8b 45 08             	mov    0x8(%ebp),%eax
 38d:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 391:	0f b6 10             	movzbl (%eax),%edx
 394:	84 d2                	test   %dl,%dl
 396:	74 09                	je     3a1 <strchr+0x1e>
    if(*s == c)
 398:	38 ca                	cmp    %cl,%dl
 39a:	74 0a                	je     3a6 <strchr+0x23>
  for(; *s; s++)
 39c:	83 c0 01             	add    $0x1,%eax
 39f:	eb f0                	jmp    391 <strchr+0xe>
      return (char*)s;
  return 0;
 3a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3a6:	5d                   	pop    %ebp
 3a7:	c3                   	ret    

000003a8 <gets>:

char*
gets(char *buf, int max)
{
 3a8:	f3 0f 1e fb          	endbr32 
 3ac:	55                   	push   %ebp
 3ad:	89 e5                	mov    %esp,%ebp
 3af:	57                   	push   %edi
 3b0:	56                   	push   %esi
 3b1:	53                   	push   %ebx
 3b2:	83 ec 1c             	sub    $0x1c,%esp
 3b5:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b8:	bb 00 00 00 00       	mov    $0x0,%ebx
 3bd:	89 de                	mov    %ebx,%esi
 3bf:	83 c3 01             	add    $0x1,%ebx
 3c2:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3c5:	7d 2e                	jge    3f5 <gets+0x4d>
    cc = read(0, &c, 1);
 3c7:	83 ec 04             	sub    $0x4,%esp
 3ca:	6a 01                	push   $0x1
 3cc:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3cf:	50                   	push   %eax
 3d0:	6a 00                	push   $0x0
 3d2:	e8 cf 01 00 00       	call   5a6 <read>
    if(cc < 1)
 3d7:	83 c4 10             	add    $0x10,%esp
 3da:	85 c0                	test   %eax,%eax
 3dc:	7e 17                	jle    3f5 <gets+0x4d>
      break;
    buf[i++] = c;
 3de:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3e2:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 3e5:	3c 0a                	cmp    $0xa,%al
 3e7:	0f 94 c2             	sete   %dl
 3ea:	3c 0d                	cmp    $0xd,%al
 3ec:	0f 94 c0             	sete   %al
 3ef:	08 c2                	or     %al,%dl
 3f1:	74 ca                	je     3bd <gets+0x15>
    buf[i++] = c;
 3f3:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3f5:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3f9:	89 f8                	mov    %edi,%eax
 3fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fe:	5b                   	pop    %ebx
 3ff:	5e                   	pop    %esi
 400:	5f                   	pop    %edi
 401:	5d                   	pop    %ebp
 402:	c3                   	ret    

00000403 <stat>:

int
stat(char *n, struct stat *st)
{
 403:	f3 0f 1e fb          	endbr32 
 407:	55                   	push   %ebp
 408:	89 e5                	mov    %esp,%ebp
 40a:	56                   	push   %esi
 40b:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 40c:	83 ec 08             	sub    $0x8,%esp
 40f:	6a 00                	push   $0x0
 411:	ff 75 08             	pushl  0x8(%ebp)
 414:	e8 b5 01 00 00       	call   5ce <open>
  if(fd < 0)
 419:	83 c4 10             	add    $0x10,%esp
 41c:	85 c0                	test   %eax,%eax
 41e:	78 24                	js     444 <stat+0x41>
 420:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 422:	83 ec 08             	sub    $0x8,%esp
 425:	ff 75 0c             	pushl  0xc(%ebp)
 428:	50                   	push   %eax
 429:	e8 b8 01 00 00       	call   5e6 <fstat>
 42e:	89 c6                	mov    %eax,%esi
  close(fd);
 430:	89 1c 24             	mov    %ebx,(%esp)
 433:	e8 7e 01 00 00       	call   5b6 <close>
  return r;
 438:	83 c4 10             	add    $0x10,%esp
}
 43b:	89 f0                	mov    %esi,%eax
 43d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 440:	5b                   	pop    %ebx
 441:	5e                   	pop    %esi
 442:	5d                   	pop    %ebp
 443:	c3                   	ret    
    return -1;
 444:	be ff ff ff ff       	mov    $0xffffffff,%esi
 449:	eb f0                	jmp    43b <stat+0x38>

0000044b <atoi>:

#ifdef PDX_XV6
int
atoi(const char *s)
{
 44b:	f3 0f 1e fb          	endbr32 
 44f:	55                   	push   %ebp
 450:	89 e5                	mov    %esp,%ebp
 452:	57                   	push   %edi
 453:	56                   	push   %esi
 454:	53                   	push   %ebx
 455:	8b 55 08             	mov    0x8(%ebp),%edx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 458:	0f b6 02             	movzbl (%edx),%eax
 45b:	3c 20                	cmp    $0x20,%al
 45d:	75 05                	jne    464 <atoi+0x19>
 45f:	83 c2 01             	add    $0x1,%edx
 462:	eb f4                	jmp    458 <atoi+0xd>
  sign = (*s == '-') ? -1 : 1;
 464:	3c 2d                	cmp    $0x2d,%al
 466:	74 1d                	je     485 <atoi+0x3a>
 468:	bf 01 00 00 00       	mov    $0x1,%edi
  if (*s == '+'  || *s == '-')
 46d:	3c 2b                	cmp    $0x2b,%al
 46f:	0f 94 c1             	sete   %cl
 472:	3c 2d                	cmp    $0x2d,%al
 474:	0f 94 c0             	sete   %al
 477:	08 c1                	or     %al,%cl
 479:	74 03                	je     47e <atoi+0x33>
    s++;
 47b:	83 c2 01             	add    $0x1,%edx
  sign = (*s == '-') ? -1 : 1;
 47e:	b8 00 00 00 00       	mov    $0x0,%eax
 483:	eb 17                	jmp    49c <atoi+0x51>
 485:	bf ff ff ff ff       	mov    $0xffffffff,%edi
 48a:	eb e1                	jmp    46d <atoi+0x22>
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
 48c:	8d 34 80             	lea    (%eax,%eax,4),%esi
 48f:	8d 1c 36             	lea    (%esi,%esi,1),%ebx
 492:	83 c2 01             	add    $0x1,%edx
 495:	0f be c9             	movsbl %cl,%ecx
 498:	8d 44 19 d0          	lea    -0x30(%ecx,%ebx,1),%eax
  while('0' <= *s && *s <= '9')
 49c:	0f b6 0a             	movzbl (%edx),%ecx
 49f:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 4a2:	80 fb 09             	cmp    $0x9,%bl
 4a5:	76 e5                	jbe    48c <atoi+0x41>
  return sign*n;
 4a7:	0f af c7             	imul   %edi,%eax
}
 4aa:	5b                   	pop    %ebx
 4ab:	5e                   	pop    %esi
 4ac:	5f                   	pop    %edi
 4ad:	5d                   	pop    %ebp
 4ae:	c3                   	ret    

000004af <atoo>:

int
atoo(const char *s)
{
 4af:	f3 0f 1e fb          	endbr32 
 4b3:	55                   	push   %ebp
 4b4:	89 e5                	mov    %esp,%ebp
 4b6:	57                   	push   %edi
 4b7:	56                   	push   %esi
 4b8:	53                   	push   %ebx
 4b9:	8b 55 08             	mov    0x8(%ebp),%edx
  int n, sign;

  n = 0;
  while (*s == ' ') s++;
 4bc:	0f b6 0a             	movzbl (%edx),%ecx
 4bf:	80 f9 20             	cmp    $0x20,%cl
 4c2:	75 05                	jne    4c9 <atoo+0x1a>
 4c4:	83 c2 01             	add    $0x1,%edx
 4c7:	eb f3                	jmp    4bc <atoo+0xd>
  sign = (*s == '-') ? -1 : 1;
 4c9:	80 f9 2d             	cmp    $0x2d,%cl
 4cc:	74 23                	je     4f1 <atoo+0x42>
 4ce:	bf 01 00 00 00       	mov    $0x1,%edi
  if (*s == '+'  || *s == '-')
 4d3:	80 f9 2b             	cmp    $0x2b,%cl
 4d6:	0f 94 c0             	sete   %al
 4d9:	89 c6                	mov    %eax,%esi
 4db:	80 f9 2d             	cmp    $0x2d,%cl
 4de:	0f 94 c0             	sete   %al
 4e1:	89 f3                	mov    %esi,%ebx
 4e3:	08 c3                	or     %al,%bl
 4e5:	74 03                	je     4ea <atoo+0x3b>
    s++;
 4e7:	83 c2 01             	add    $0x1,%edx
  sign = (*s == '-') ? -1 : 1;
 4ea:	b8 00 00 00 00       	mov    $0x0,%eax
 4ef:	eb 11                	jmp    502 <atoo+0x53>
 4f1:	bf ff ff ff ff       	mov    $0xffffffff,%edi
 4f6:	eb db                	jmp    4d3 <atoo+0x24>
  while('0' <= *s && *s <= '7')
    n = n*8 + *s++ - '0';
 4f8:	83 c2 01             	add    $0x1,%edx
 4fb:	0f be c9             	movsbl %cl,%ecx
 4fe:	8d 44 c1 d0          	lea    -0x30(%ecx,%eax,8),%eax
  while('0' <= *s && *s <= '7')
 502:	0f b6 0a             	movzbl (%edx),%ecx
 505:	8d 59 d0             	lea    -0x30(%ecx),%ebx
 508:	80 fb 07             	cmp    $0x7,%bl
 50b:	76 eb                	jbe    4f8 <atoo+0x49>
  return sign*n;
 50d:	0f af c7             	imul   %edi,%eax
}
 510:	5b                   	pop    %ebx
 511:	5e                   	pop    %esi
 512:	5f                   	pop    %edi
 513:	5d                   	pop    %ebp
 514:	c3                   	ret    

00000515 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 515:	f3 0f 1e fb          	endbr32 
 519:	55                   	push   %ebp
 51a:	89 e5                	mov    %esp,%ebp
 51c:	53                   	push   %ebx
 51d:	8b 55 08             	mov    0x8(%ebp),%edx
 520:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 523:	8b 45 10             	mov    0x10(%ebp),%eax
    while(n > 0 && *p && *p == *q)
 526:	eb 09                	jmp    531 <strncmp+0x1c>
      n--, p++, q++;
 528:	83 e8 01             	sub    $0x1,%eax
 52b:	83 c2 01             	add    $0x1,%edx
 52e:	83 c1 01             	add    $0x1,%ecx
    while(n > 0 && *p && *p == *q)
 531:	85 c0                	test   %eax,%eax
 533:	74 0b                	je     540 <strncmp+0x2b>
 535:	0f b6 1a             	movzbl (%edx),%ebx
 538:	84 db                	test   %bl,%bl
 53a:	74 04                	je     540 <strncmp+0x2b>
 53c:	3a 19                	cmp    (%ecx),%bl
 53e:	74 e8                	je     528 <strncmp+0x13>
    if(n == 0)
 540:	85 c0                	test   %eax,%eax
 542:	74 0b                	je     54f <strncmp+0x3a>
      return 0;
    return (uchar)*p - (uchar)*q;
 544:	0f b6 02             	movzbl (%edx),%eax
 547:	0f b6 11             	movzbl (%ecx),%edx
 54a:	29 d0                	sub    %edx,%eax
}
 54c:	5b                   	pop    %ebx
 54d:	5d                   	pop    %ebp
 54e:	c3                   	ret    
      return 0;
 54f:	b8 00 00 00 00       	mov    $0x0,%eax
 554:	eb f6                	jmp    54c <strncmp+0x37>

00000556 <memmove>:
}
#endif // PDX_XV6

void*
memmove(void *vdst, void *vsrc, int n)
{
 556:	f3 0f 1e fb          	endbr32 
 55a:	55                   	push   %ebp
 55b:	89 e5                	mov    %esp,%ebp
 55d:	56                   	push   %esi
 55e:	53                   	push   %ebx
 55f:	8b 75 08             	mov    0x8(%ebp),%esi
 562:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 565:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst, *src;

  dst = vdst;
 568:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 56a:	8d 58 ff             	lea    -0x1(%eax),%ebx
 56d:	85 c0                	test   %eax,%eax
 56f:	7e 0f                	jle    580 <memmove+0x2a>
    *dst++ = *src++;
 571:	0f b6 01             	movzbl (%ecx),%eax
 574:	88 02                	mov    %al,(%edx)
 576:	8d 49 01             	lea    0x1(%ecx),%ecx
 579:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 57c:	89 d8                	mov    %ebx,%eax
 57e:	eb ea                	jmp    56a <memmove+0x14>
  return vdst;
}
 580:	89 f0                	mov    %esi,%eax
 582:	5b                   	pop    %ebx
 583:	5e                   	pop    %esi
 584:	5d                   	pop    %ebp
 585:	c3                   	ret    

00000586 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 586:	b8 01 00 00 00       	mov    $0x1,%eax
 58b:	cd 40                	int    $0x40
 58d:	c3                   	ret    

0000058e <exit>:
SYSCALL(exit)
 58e:	b8 02 00 00 00       	mov    $0x2,%eax
 593:	cd 40                	int    $0x40
 595:	c3                   	ret    

00000596 <wait>:
SYSCALL(wait)
 596:	b8 03 00 00 00       	mov    $0x3,%eax
 59b:	cd 40                	int    $0x40
 59d:	c3                   	ret    

0000059e <pipe>:
SYSCALL(pipe)
 59e:	b8 04 00 00 00       	mov    $0x4,%eax
 5a3:	cd 40                	int    $0x40
 5a5:	c3                   	ret    

000005a6 <read>:
SYSCALL(read)
 5a6:	b8 05 00 00 00       	mov    $0x5,%eax
 5ab:	cd 40                	int    $0x40
 5ad:	c3                   	ret    

000005ae <write>:
SYSCALL(write)
 5ae:	b8 10 00 00 00       	mov    $0x10,%eax
 5b3:	cd 40                	int    $0x40
 5b5:	c3                   	ret    

000005b6 <close>:
SYSCALL(close)
 5b6:	b8 15 00 00 00       	mov    $0x15,%eax
 5bb:	cd 40                	int    $0x40
 5bd:	c3                   	ret    

000005be <kill>:
SYSCALL(kill)
 5be:	b8 06 00 00 00       	mov    $0x6,%eax
 5c3:	cd 40                	int    $0x40
 5c5:	c3                   	ret    

000005c6 <exec>:
SYSCALL(exec)
 5c6:	b8 07 00 00 00       	mov    $0x7,%eax
 5cb:	cd 40                	int    $0x40
 5cd:	c3                   	ret    

000005ce <open>:
SYSCALL(open)
 5ce:	b8 0f 00 00 00       	mov    $0xf,%eax
 5d3:	cd 40                	int    $0x40
 5d5:	c3                   	ret    

000005d6 <mknod>:
SYSCALL(mknod)
 5d6:	b8 11 00 00 00       	mov    $0x11,%eax
 5db:	cd 40                	int    $0x40
 5dd:	c3                   	ret    

000005de <unlink>:
SYSCALL(unlink)
 5de:	b8 12 00 00 00       	mov    $0x12,%eax
 5e3:	cd 40                	int    $0x40
 5e5:	c3                   	ret    

000005e6 <fstat>:
SYSCALL(fstat)
 5e6:	b8 08 00 00 00       	mov    $0x8,%eax
 5eb:	cd 40                	int    $0x40
 5ed:	c3                   	ret    

000005ee <link>:
SYSCALL(link)
 5ee:	b8 13 00 00 00       	mov    $0x13,%eax
 5f3:	cd 40                	int    $0x40
 5f5:	c3                   	ret    

000005f6 <mkdir>:
SYSCALL(mkdir)
 5f6:	b8 14 00 00 00       	mov    $0x14,%eax
 5fb:	cd 40                	int    $0x40
 5fd:	c3                   	ret    

000005fe <chdir>:
SYSCALL(chdir)
 5fe:	b8 09 00 00 00       	mov    $0x9,%eax
 603:	cd 40                	int    $0x40
 605:	c3                   	ret    

00000606 <dup>:
SYSCALL(dup)
 606:	b8 0a 00 00 00       	mov    $0xa,%eax
 60b:	cd 40                	int    $0x40
 60d:	c3                   	ret    

0000060e <getpid>:
SYSCALL(getpid)
 60e:	b8 0b 00 00 00       	mov    $0xb,%eax
 613:	cd 40                	int    $0x40
 615:	c3                   	ret    

00000616 <sbrk>:
SYSCALL(sbrk)
 616:	b8 0c 00 00 00       	mov    $0xc,%eax
 61b:	cd 40                	int    $0x40
 61d:	c3                   	ret    

0000061e <sleep>:
SYSCALL(sleep)
 61e:	b8 0d 00 00 00       	mov    $0xd,%eax
 623:	cd 40                	int    $0x40
 625:	c3                   	ret    

00000626 <uptime>:
SYSCALL(uptime)
 626:	b8 0e 00 00 00       	mov    $0xe,%eax
 62b:	cd 40                	int    $0x40
 62d:	c3                   	ret    

0000062e <halt>:
SYSCALL(halt)
 62e:	b8 16 00 00 00       	mov    $0x16,%eax
 633:	cd 40                	int    $0x40
 635:	c3                   	ret    

00000636 <date>:
SYSCALL(date)
 636:	b8 17 00 00 00       	mov    $0x17,%eax
 63b:	cd 40                	int    $0x40
 63d:	c3                   	ret    

0000063e <getuid>:
SYSCALL(getuid)
 63e:	b8 18 00 00 00       	mov    $0x18,%eax
 643:	cd 40                	int    $0x40
 645:	c3                   	ret    

00000646 <getgid>:
SYSCALL(getgid)
 646:	b8 19 00 00 00       	mov    $0x19,%eax
 64b:	cd 40                	int    $0x40
 64d:	c3                   	ret    

0000064e <getppid>:
SYSCALL(getppid)
 64e:	b8 1a 00 00 00       	mov    $0x1a,%eax
 653:	cd 40                	int    $0x40
 655:	c3                   	ret    

00000656 <setuid>:
SYSCALL(setuid)
 656:	b8 1b 00 00 00       	mov    $0x1b,%eax
 65b:	cd 40                	int    $0x40
 65d:	c3                   	ret    

0000065e <setgid>:
SYSCALL(setgid)
 65e:	b8 1c 00 00 00       	mov    $0x1c,%eax
 663:	cd 40                	int    $0x40
 665:	c3                   	ret    

00000666 <getprocs>:
SYSCALL(getprocs)
 666:	b8 1d 00 00 00       	mov    $0x1d,%eax
 66b:	cd 40                	int    $0x40
 66d:	c3                   	ret    

0000066e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 66e:	55                   	push   %ebp
 66f:	89 e5                	mov    %esp,%ebp
 671:	83 ec 1c             	sub    $0x1c,%esp
 674:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 677:	6a 01                	push   $0x1
 679:	8d 55 f4             	lea    -0xc(%ebp),%edx
 67c:	52                   	push   %edx
 67d:	50                   	push   %eax
 67e:	e8 2b ff ff ff       	call   5ae <write>
}
 683:	83 c4 10             	add    $0x10,%esp
 686:	c9                   	leave  
 687:	c3                   	ret    

00000688 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 688:	55                   	push   %ebp
 689:	89 e5                	mov    %esp,%ebp
 68b:	57                   	push   %edi
 68c:	56                   	push   %esi
 68d:	53                   	push   %ebx
 68e:	83 ec 2c             	sub    $0x2c,%esp
 691:	89 45 d0             	mov    %eax,-0x30(%ebp)
 694:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 696:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 69a:	0f 95 c2             	setne  %dl
 69d:	89 f0                	mov    %esi,%eax
 69f:	c1 e8 1f             	shr    $0x1f,%eax
 6a2:	84 c2                	test   %al,%dl
 6a4:	74 42                	je     6e8 <printint+0x60>
    neg = 1;
    x = -xx;
 6a6:	f7 de                	neg    %esi
    neg = 1;
 6a8:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 6af:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 6b4:	89 f0                	mov    %esi,%eax
 6b6:	ba 00 00 00 00       	mov    $0x0,%edx
 6bb:	f7 f1                	div    %ecx
 6bd:	89 df                	mov    %ebx,%edi
 6bf:	83 c3 01             	add    $0x1,%ebx
 6c2:	0f b6 92 20 0a 00 00 	movzbl 0xa20(%edx),%edx
 6c9:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 6cd:	89 f2                	mov    %esi,%edx
 6cf:	89 c6                	mov    %eax,%esi
 6d1:	39 d1                	cmp    %edx,%ecx
 6d3:	76 df                	jbe    6b4 <printint+0x2c>
  if(neg)
 6d5:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 6d9:	74 2f                	je     70a <printint+0x82>
    buf[i++] = '-';
 6db:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 6e0:	8d 5f 02             	lea    0x2(%edi),%ebx
 6e3:	8b 75 d0             	mov    -0x30(%ebp),%esi
 6e6:	eb 15                	jmp    6fd <printint+0x75>
  neg = 0;
 6e8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 6ef:	eb be                	jmp    6af <printint+0x27>

  while(--i >= 0)
    putc(fd, buf[i]);
 6f1:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 6f6:	89 f0                	mov    %esi,%eax
 6f8:	e8 71 ff ff ff       	call   66e <putc>
  while(--i >= 0)
 6fd:	83 eb 01             	sub    $0x1,%ebx
 700:	79 ef                	jns    6f1 <printint+0x69>
}
 702:	83 c4 2c             	add    $0x2c,%esp
 705:	5b                   	pop    %ebx
 706:	5e                   	pop    %esi
 707:	5f                   	pop    %edi
 708:	5d                   	pop    %ebp
 709:	c3                   	ret    
 70a:	8b 75 d0             	mov    -0x30(%ebp),%esi
 70d:	eb ee                	jmp    6fd <printint+0x75>

0000070f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 70f:	f3 0f 1e fb          	endbr32 
 713:	55                   	push   %ebp
 714:	89 e5                	mov    %esp,%ebp
 716:	57                   	push   %edi
 717:	56                   	push   %esi
 718:	53                   	push   %ebx
 719:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 71c:	8d 45 10             	lea    0x10(%ebp),%eax
 71f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 722:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 727:	bb 00 00 00 00       	mov    $0x0,%ebx
 72c:	eb 14                	jmp    742 <printf+0x33>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 72e:	89 fa                	mov    %edi,%edx
 730:	8b 45 08             	mov    0x8(%ebp),%eax
 733:	e8 36 ff ff ff       	call   66e <putc>
 738:	eb 05                	jmp    73f <printf+0x30>
      }
    } else if(state == '%'){
 73a:	83 fe 25             	cmp    $0x25,%esi
 73d:	74 25                	je     764 <printf+0x55>
  for(i = 0; fmt[i]; i++){
 73f:	83 c3 01             	add    $0x1,%ebx
 742:	8b 45 0c             	mov    0xc(%ebp),%eax
 745:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 749:	84 c0                	test   %al,%al
 74b:	0f 84 23 01 00 00    	je     874 <printf+0x165>
    c = fmt[i] & 0xff;
 751:	0f be f8             	movsbl %al,%edi
 754:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 757:	85 f6                	test   %esi,%esi
 759:	75 df                	jne    73a <printf+0x2b>
      if(c == '%'){
 75b:	83 f8 25             	cmp    $0x25,%eax
 75e:	75 ce                	jne    72e <printf+0x1f>
        state = '%';
 760:	89 c6                	mov    %eax,%esi
 762:	eb db                	jmp    73f <printf+0x30>
      if(c == 'd'){
 764:	83 f8 64             	cmp    $0x64,%eax
 767:	74 49                	je     7b2 <printf+0xa3>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 769:	83 f8 78             	cmp    $0x78,%eax
 76c:	0f 94 c1             	sete   %cl
 76f:	83 f8 70             	cmp    $0x70,%eax
 772:	0f 94 c2             	sete   %dl
 775:	08 d1                	or     %dl,%cl
 777:	75 63                	jne    7dc <printf+0xcd>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 779:	83 f8 73             	cmp    $0x73,%eax
 77c:	0f 84 84 00 00 00    	je     806 <printf+0xf7>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 782:	83 f8 63             	cmp    $0x63,%eax
 785:	0f 84 b7 00 00 00    	je     842 <printf+0x133>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 78b:	83 f8 25             	cmp    $0x25,%eax
 78e:	0f 84 cc 00 00 00    	je     860 <printf+0x151>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 794:	ba 25 00 00 00       	mov    $0x25,%edx
 799:	8b 45 08             	mov    0x8(%ebp),%eax
 79c:	e8 cd fe ff ff       	call   66e <putc>
        putc(fd, c);
 7a1:	89 fa                	mov    %edi,%edx
 7a3:	8b 45 08             	mov    0x8(%ebp),%eax
 7a6:	e8 c3 fe ff ff       	call   66e <putc>
      }
      state = 0;
 7ab:	be 00 00 00 00       	mov    $0x0,%esi
 7b0:	eb 8d                	jmp    73f <printf+0x30>
        printint(fd, *ap, 10, 1);
 7b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 7b5:	8b 17                	mov    (%edi),%edx
 7b7:	83 ec 0c             	sub    $0xc,%esp
 7ba:	6a 01                	push   $0x1
 7bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7c1:	8b 45 08             	mov    0x8(%ebp),%eax
 7c4:	e8 bf fe ff ff       	call   688 <printint>
        ap++;
 7c9:	83 c7 04             	add    $0x4,%edi
 7cc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 7cf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7d2:	be 00 00 00 00       	mov    $0x0,%esi
 7d7:	e9 63 ff ff ff       	jmp    73f <printf+0x30>
        printint(fd, *ap, 16, 0);
 7dc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 7df:	8b 17                	mov    (%edi),%edx
 7e1:	83 ec 0c             	sub    $0xc,%esp
 7e4:	6a 00                	push   $0x0
 7e6:	b9 10 00 00 00       	mov    $0x10,%ecx
 7eb:	8b 45 08             	mov    0x8(%ebp),%eax
 7ee:	e8 95 fe ff ff       	call   688 <printint>
        ap++;
 7f3:	83 c7 04             	add    $0x4,%edi
 7f6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 7f9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7fc:	be 00 00 00 00       	mov    $0x0,%esi
 801:	e9 39 ff ff ff       	jmp    73f <printf+0x30>
        s = (char*)*ap;
 806:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 809:	8b 30                	mov    (%eax),%esi
        ap++;
 80b:	83 c0 04             	add    $0x4,%eax
 80e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 811:	85 f6                	test   %esi,%esi
 813:	75 28                	jne    83d <printf+0x12e>
          s = "(null)";
 815:	be 16 0a 00 00       	mov    $0xa16,%esi
 81a:	8b 7d 08             	mov    0x8(%ebp),%edi
 81d:	eb 0d                	jmp    82c <printf+0x11d>
          putc(fd, *s);
 81f:	0f be d2             	movsbl %dl,%edx
 822:	89 f8                	mov    %edi,%eax
 824:	e8 45 fe ff ff       	call   66e <putc>
          s++;
 829:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 82c:	0f b6 16             	movzbl (%esi),%edx
 82f:	84 d2                	test   %dl,%dl
 831:	75 ec                	jne    81f <printf+0x110>
      state = 0;
 833:	be 00 00 00 00       	mov    $0x0,%esi
 838:	e9 02 ff ff ff       	jmp    73f <printf+0x30>
 83d:	8b 7d 08             	mov    0x8(%ebp),%edi
 840:	eb ea                	jmp    82c <printf+0x11d>
        putc(fd, *ap);
 842:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 845:	0f be 17             	movsbl (%edi),%edx
 848:	8b 45 08             	mov    0x8(%ebp),%eax
 84b:	e8 1e fe ff ff       	call   66e <putc>
        ap++;
 850:	83 c7 04             	add    $0x4,%edi
 853:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 856:	be 00 00 00 00       	mov    $0x0,%esi
 85b:	e9 df fe ff ff       	jmp    73f <printf+0x30>
        putc(fd, c);
 860:	89 fa                	mov    %edi,%edx
 862:	8b 45 08             	mov    0x8(%ebp),%eax
 865:	e8 04 fe ff ff       	call   66e <putc>
      state = 0;
 86a:	be 00 00 00 00       	mov    $0x0,%esi
 86f:	e9 cb fe ff ff       	jmp    73f <printf+0x30>
    }
  }
}
 874:	8d 65 f4             	lea    -0xc(%ebp),%esp
 877:	5b                   	pop    %ebx
 878:	5e                   	pop    %esi
 879:	5f                   	pop    %edi
 87a:	5d                   	pop    %ebp
 87b:	c3                   	ret    

0000087c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 87c:	f3 0f 1e fb          	endbr32 
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	56                   	push   %esi
 885:	53                   	push   %ebx
 886:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 889:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88c:	a1 94 0d 00 00       	mov    0xd94,%eax
 891:	eb 02                	jmp    895 <free+0x19>
 893:	89 d0                	mov    %edx,%eax
 895:	39 c8                	cmp    %ecx,%eax
 897:	73 04                	jae    89d <free+0x21>
 899:	39 08                	cmp    %ecx,(%eax)
 89b:	77 12                	ja     8af <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89d:	8b 10                	mov    (%eax),%edx
 89f:	39 c2                	cmp    %eax,%edx
 8a1:	77 f0                	ja     893 <free+0x17>
 8a3:	39 c8                	cmp    %ecx,%eax
 8a5:	72 08                	jb     8af <free+0x33>
 8a7:	39 ca                	cmp    %ecx,%edx
 8a9:	77 04                	ja     8af <free+0x33>
 8ab:	89 d0                	mov    %edx,%eax
 8ad:	eb e6                	jmp    895 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8af:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8b2:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8b5:	8b 10                	mov    (%eax),%edx
 8b7:	39 d7                	cmp    %edx,%edi
 8b9:	74 19                	je     8d4 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8bb:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8be:	8b 50 04             	mov    0x4(%eax),%edx
 8c1:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8c4:	39 ce                	cmp    %ecx,%esi
 8c6:	74 1b                	je     8e3 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8c8:	89 08                	mov    %ecx,(%eax)
  freep = p;
 8ca:	a3 94 0d 00 00       	mov    %eax,0xd94
}
 8cf:	5b                   	pop    %ebx
 8d0:	5e                   	pop    %esi
 8d1:	5f                   	pop    %edi
 8d2:	5d                   	pop    %ebp
 8d3:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 8d4:	03 72 04             	add    0x4(%edx),%esi
 8d7:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8da:	8b 10                	mov    (%eax),%edx
 8dc:	8b 12                	mov    (%edx),%edx
 8de:	89 53 f8             	mov    %edx,-0x8(%ebx)
 8e1:	eb db                	jmp    8be <free+0x42>
    p->s.size += bp->s.size;
 8e3:	03 53 fc             	add    -0x4(%ebx),%edx
 8e6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8e9:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8ec:	89 10                	mov    %edx,(%eax)
 8ee:	eb da                	jmp    8ca <free+0x4e>

000008f0 <morecore>:

static Header*
morecore(uint nu)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	53                   	push   %ebx
 8f4:	83 ec 04             	sub    $0x4,%esp
 8f7:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 8f9:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 8fe:	77 05                	ja     905 <morecore+0x15>
    nu = 4096;
 900:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 905:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 90c:	83 ec 0c             	sub    $0xc,%esp
 90f:	50                   	push   %eax
 910:	e8 01 fd ff ff       	call   616 <sbrk>
  if(p == (char*)-1)
 915:	83 c4 10             	add    $0x10,%esp
 918:	83 f8 ff             	cmp    $0xffffffff,%eax
 91b:	74 1c                	je     939 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 91d:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 920:	83 c0 08             	add    $0x8,%eax
 923:	83 ec 0c             	sub    $0xc,%esp
 926:	50                   	push   %eax
 927:	e8 50 ff ff ff       	call   87c <free>
  return freep;
 92c:	a1 94 0d 00 00       	mov    0xd94,%eax
 931:	83 c4 10             	add    $0x10,%esp
}
 934:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 937:	c9                   	leave  
 938:	c3                   	ret    
    return 0;
 939:	b8 00 00 00 00       	mov    $0x0,%eax
 93e:	eb f4                	jmp    934 <morecore+0x44>

00000940 <malloc>:

void*
malloc(uint nbytes)
{
 940:	f3 0f 1e fb          	endbr32 
 944:	55                   	push   %ebp
 945:	89 e5                	mov    %esp,%ebp
 947:	53                   	push   %ebx
 948:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 94b:	8b 45 08             	mov    0x8(%ebp),%eax
 94e:	8d 58 07             	lea    0x7(%eax),%ebx
 951:	c1 eb 03             	shr    $0x3,%ebx
 954:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 957:	8b 0d 94 0d 00 00    	mov    0xd94,%ecx
 95d:	85 c9                	test   %ecx,%ecx
 95f:	74 04                	je     965 <malloc+0x25>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 961:	8b 01                	mov    (%ecx),%eax
 963:	eb 4b                	jmp    9b0 <malloc+0x70>
    base.s.ptr = freep = prevp = &base;
 965:	c7 05 94 0d 00 00 98 	movl   $0xd98,0xd94
 96c:	0d 00 00 
 96f:	c7 05 98 0d 00 00 98 	movl   $0xd98,0xd98
 976:	0d 00 00 
    base.s.size = 0;
 979:	c7 05 9c 0d 00 00 00 	movl   $0x0,0xd9c
 980:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 983:	b9 98 0d 00 00       	mov    $0xd98,%ecx
 988:	eb d7                	jmp    961 <malloc+0x21>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 98a:	74 1a                	je     9a6 <malloc+0x66>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 98c:	29 da                	sub    %ebx,%edx
 98e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 991:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 994:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 997:	89 0d 94 0d 00 00    	mov    %ecx,0xd94
      return (void*)(p + 1);
 99d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9a0:	83 c4 04             	add    $0x4,%esp
 9a3:	5b                   	pop    %ebx
 9a4:	5d                   	pop    %ebp
 9a5:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 9a6:	8b 10                	mov    (%eax),%edx
 9a8:	89 11                	mov    %edx,(%ecx)
 9aa:	eb eb                	jmp    997 <malloc+0x57>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ac:	89 c1                	mov    %eax,%ecx
 9ae:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 9b0:	8b 50 04             	mov    0x4(%eax),%edx
 9b3:	39 da                	cmp    %ebx,%edx
 9b5:	73 d3                	jae    98a <malloc+0x4a>
    if(p == freep)
 9b7:	39 05 94 0d 00 00    	cmp    %eax,0xd94
 9bd:	75 ed                	jne    9ac <malloc+0x6c>
      if((p = morecore(nunits)) == 0)
 9bf:	89 d8                	mov    %ebx,%eax
 9c1:	e8 2a ff ff ff       	call   8f0 <morecore>
 9c6:	85 c0                	test   %eax,%eax
 9c8:	75 e2                	jne    9ac <malloc+0x6c>
 9ca:	eb d4                	jmp    9a0 <malloc+0x60>
